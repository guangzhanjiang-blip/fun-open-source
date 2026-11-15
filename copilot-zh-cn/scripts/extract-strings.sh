#!/usr/bin/env bash
# 从 VS Code Marketplace 重新下载最新版 Copilot / Copilot Chat .vsix，
# 解包并抽取可翻译字符串清单，供补翻新版使用。
#
# 用法：bash scripts/extract-strings.sh
# 产物：
#   extract-copilot/extension/package.json        （核心扩展清单，核对命令标题）
#   extract-chat/extension/package.nls.json       （Chat 清单英文底本）
#   extract-chat/extension/package.nls.zh-cn.json （Chat 官方自带中文，供对照）
#   chat-runtime-strings.json                     （Chat 运行时 l10n.t() 字符串）
#
# 注意：
# - .vsix 是 gzip 包了一层 zip：先 gunzip 再 unzip。
# - Copilot Chat 自带 package.nls.zh-cn.json（官方已翻清单层），
#   真正要补的是运行时字符串（dist/extension.js 里的 l10n.t() 调用）。
# - 核心扩展（GitHub.copilot）无 package.nls.json，命令标题写死在
#   package.json 里，语言包暂时无法替换，翻译文件仅作储备。
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== 下载最新版 .vsix =="
curl -sL -A "Mozilla/5.0" -o copilot.vsix.gz \
  "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/latest/vspackage"
curl -sL -A "Mozilla/5.0" -o copilot-chat.vsix.gz \
  "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot-chat/latest/vspackage"
gunzip -f copilot.vsix.gz copilot-chat.vsix.gz

echo "== 解包 =="
rm -rf extract-copilot extract-chat
unzip -qo copilot.vsix -d extract-copilot
unzip -qo copilot-chat.vsix -d extract-chat

echo "== 版本 =="
python3 -c "
import json
for name in ('extract-copilot', 'extract-chat'):
    d = json.load(open(f'{name}/extension/package.json'))
    print(f\"{d['publisher']}.{d['name']}: {d['version']}\")"

echo "== 抽取 Chat 运行时字符串 =="
python3 - <<'PYEOF'
import re, json, glob

def extract_l10n(path):
    src = open(path, encoding='utf-8', errors='ignore').read()
    out = set()
    for m in re.finditer(r'l10n\.t\(\s*("(?:[^"\\]|\\.)*"|\'(?:[^\'\\]|\\.)*\')', src):
        lit = m.group(1)
        try: out.add(json.loads(lit))
        except Exception: out.add(lit[1:-1])
    for m in re.finditer(r'l10n\.t\(\s*\{\s*message\s*:\s*("(?:[^"\\]|\\.)*"|\'(?:[^\'\\]|\\.)*\')', src):
        lit = m.group(1)
        try: out.add(json.loads(lit))
        except Exception: out.add(lit[1:-1])
    return out

allstr = set()
for f in glob.glob('extract-chat/extension/dist/*.js'):
    allstr |= extract_l10n(f)

def is_ui(s):
    s2 = s.strip()
    if not s2 or len(s2) > 300: return False
    if not re.search(r'[A-Za-z]', s2): return False
    if re.search(r'[{}();=<>+\n\r]', s2): return False
    if s2.startswith(('+','-','/','\\','$','_', '.', ',')): return False
    if re.match(r'^[a-zA-Z0-9_.\-/]+$', s2): return False
    if 'http' in s2 and ' ' not in s2: return False
    return True

good = sorted(s for s in allstr if is_ui(s))
json.dump(good, open('chat-runtime-strings.json','w',encoding='utf-8'), ensure_ascii=False, indent=1)
print(f"runtime UI strings: {len(good)} -> chat-runtime-strings.json")
PYEOF

echo "== 清单层对照 =="
python3 -c "
import json
en=json.load(open('extract-chat/extension/package.nls.json'))
zh=json.load(open('extract-chat/extension/package.nls.zh-cn.json'))
print(f\"manifest keys: en={len(en)} zh={len(zh)} identical={sum(1 for k in en if en.get(k)==zh.get(k))}\")"
echo "完成。下一步：把新增的英文串翻成中文，补进 translate-runtime.py，跑 python3 build-pack.py 重新生成翻译文件。"
