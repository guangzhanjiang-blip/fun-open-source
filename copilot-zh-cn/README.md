# GitHub Copilot 简体中文语言包

给 **GitHub Copilot**（`GitHub.copilot`）和 **GitHub Copilot Chat**（`GitHub.copilot-chat`）做的社区简体中文语言包。把 Copilot 的界面字符串（命令、聊天面板、设置、通知、报错等）翻译成中文。

> 基于 Copilot 1.388.0 / Copilot Chat 0.48.1（2026-11-15 提取）。只含翻译字符串文件，**不含 Copilot 代码**。

## 为什么需要这个包

微软官方中文语言包（`microsoft/vscode-loc`）里没有 Copilot，因为 Copilot 是 Marketplace 扩展、不是 VS Code 内置扩展，官方语言包不管它。

另外注意一个容易混淆的点：Copilot 自带设置 `github.copilot.chat.localeOverride`，设成 `"zh-CN"` 能让聊天**回答**变成中文，但**不管界面**——菜单、命令、设置项、按钮、通知还是英文。本包补的就是界面这一层。

## 翻译覆盖

| 扩展 | 清单字符串（package.nls） | 运行时字符串（l10n） |
|---|---|---|
| `github.copilot-chat` 0.48.1 | 456 条（清单层；其中 454 条官方扩展自带中文，本包沿用并补全） | 255 条（从 `dist/extension.js` 的 `l10n.t()` 调用中提取并翻译，**这是本包真正的增量**） |
| `github.copilot` 1.388.0 | 19 条命令标题已翻译（见下） | 该扩展未使用 `l10n` |

### 关于 `github.copilot`（核心扩展）的说明

实测 v1.388.0：核心扩展**没有** `package.nls.json`，19 条命令标题是直接写死在 `package.json` 里的英文，语言包机制无法替换它们。本包的 `github.copilot.i18n.json` 已把这 19 条翻好（按键名 `command id` 存放），待 GitHub 哪天改用 nls 键后即可生效。当前版本下，核心扩展的命令标题仍显示英文，这是扩展本身的限制，不是本包的问题。

## 安装

### 方式一：从源码打包安装（推荐）

```bash
git clone https://github.com/guangzhanjiang-blip/fun-open-source.git
cd fun-open-source/copilot-zh-cn
npm install -g @vscode/vsce
vsce package
code --install-extension copilot-zh-cn-0.48.1.vsix
```

### 方式二：手动放进扩展目录

把 `copilot-zh-cn/` 整个文件夹复制到 VS Code 扩展目录（`~/.vscode/extensions/`），重启 VS Code。

### 启用

1. 把 VS Code 显示语言设为中文（`Ctrl+Shift+P` → `Configure Display Language` → `中文(简体)`）。
2. 重启 VS Code。Copilot Chat 的界面即显示中文。

同时建议把聊天回答也设为中文：

```json
"github.copilot.chat.localeOverride": "zh-CN"
```

## 目录结构

```
copilot-zh-cn/
├── package.json                  # 语言包扩展清单（contributes.localizations）
├── translations/
│   └── extensions/
│       ├── github.copilot.i18n.json       # 核心扩展 19 条命令标题
│       └── github.copilot-chat.i18n.json  # Chat 456 条清单 + 255 条运行时字符串
├── scripts/
│   └── extract-strings.sh        # 从新版 .vsix 重新抽取字符串
├── build-pack.py                 # 生成翻译文件的构建脚本
├── translate-runtime.py          # 运行时字符串翻译表
└── README.md
```

## 更新到新版本

Copilot 每次发新版，字符串都可能变。跑一遍抽取脚本重新提取，再补翻新增的 key 即可（缺失的 key 会自动回退英文，不会坏）：

```bash
bash scripts/extract-strings.sh
```

详见 `scripts/extract-strings.sh` 内的注释。

## 许可

翻译内容采用 MIT 协议。Copilot 本身是 GitHub 的闭源产品，本包不含其任何代码。
