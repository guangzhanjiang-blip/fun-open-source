# -*- coding: utf-8 -*-
"""Build the copilot-zh-cn language pack files + repo docs."""
import json, os

BASE = os.path.dirname(os.path.abspath(__file__))
EXTRACT = BASE

# --- 1. Copilot Chat manifest translations (publisher zh-cn, already translated) ---
chat_manifest = json.load(open(os.path.join(EXTRACT, "extract-chat/extension/package.nls.zh-cn.json"), encoding="utf-8"))

# --- 2. Copilot Chat runtime translations (our translations) ---
runtime = json.load(open(os.path.join(EXTRACT, "chat-runtime-zh.json"), encoding="utf-8"))

# Merge: manifest keys + runtime strings (keyed by English source string)
chat_i18n = dict(chat_manifest)
overlap = set(chat_i18n) & set(runtime)
print("manifest keys:", len(chat_manifest), "runtime:", len(runtime), "overlap:", len(overlap))
chat_i18n.update(runtime)
print("github.copilot-chat.i18n.json total:", len(chat_i18n))

# --- 3. Copilot core (GitHub.copilot 1.388.0) command titles ---
# NOTE: v1.388.0 hardcodes these titles in package.json (no package.nls.json),
# so a language pack cannot apply them yet. Ship the translations keyed by
# command id so they are ready if/when GitHub adopts nls keys.
core_i18n = {
    "github.copilot.toggleStatusMenu": "打开状态菜单",
    "github.copilot.signIn": "登录",
    "github.copilot.acceptCursorPanelSolution": "接受光标处的面板建议",
    "github.copilot.previousPanelSolution": "转到上一条面板建议",
    "github.copilot.nextPanelSolution": "转到下一条面板建议",
    "github.copilot.generate": "打开补全面板",
    "github.copilot.generateComparison": "打开比较面板",
    "github.copilot.acceptCursorComparisonPanelSolution": "接受光标处的比较面板建议",
    "github.copilot.previousComparisonPanelSolution": "转到上一条比较面板建议",
    "github.copilot.nextComparisonPanelSolution": "转到下一条比较面板建议",
    "github.copilot.completions.disable": "禁用补全",
    "github.copilot.completions.enable": "启用补全",
    "github.copilot.completions.toggle": "切换（启用/禁用）补全",
    "github.copilot.sendFeedback": "发送反馈",
    "github.copilot.collectDiagnostics": "收集诊断信息",
    "github.copilot.openLogs": "打开日志",
    "github.copilot.openModelPicker": "更改补全模型",
    "github.copilot.sendCompletionFeedback": "发送 Copilot 补全反馈",
    "github-copilot-completions-debugger-view.refresh": "刷新",
}
print("github.copilot.i18n.json total:", len(core_i18n))

out_trans = os.path.join(BASE, "translations", "extensions")
os.makedirs(out_trans, exist_ok=True)
json.dump(chat_i18n, open(os.path.join(out_trans, "github.copilot-chat.i18n.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=2)
json.dump(core_i18n, open(os.path.join(out_trans, "github.copilot.i18n.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=2)

# --- 4. Language pack package.json ---
pkg = {
    "name": "copilot-zh-cn",
    "displayName": "GitHub Copilot 简体中文语言包",
    "description": "GitHub Copilot / Copilot Chat 界面简体中文翻译。补完官方中文语言包未覆盖的 Copilot 界面字符串（命令、聊天面板、通知、报错等）。",
    "version": "0.48.1",
    "publisher": "guangzhanjiang-blip",
    "license": "MIT",
    "engines": {"vscode": "^1.90.0"},
    "categories": ["Language Packs"],
    "contributes": {
        "localizations": [
            {
                "languageId": "zh-cn",
                "languageName": "Chinese (Simplified)",
                "localizedLanguageName": "中文(简体)",
                "translations": [
                    {"id": "github.copilot", "path": "./translations/extensions/github.copilot.i18n.json"},
                    {"id": "github.copilot-chat", "path": "./translations/extensions/github.copilot-chat.i18n.json"}
                ]
            }
        ]
    }
}
json.dump(pkg, open(os.path.join(BASE, "package.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print("wrote package.json, translation files")
