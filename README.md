# fun-open-source

收好玩的开源项目。

## 内容

### GitHub Copilot 简体中文语言包 —— [`copilot-zh-cn/`](copilot-zh-cn/)

给 GitHub Copilot / Copilot Chat 做的社区简体中文语言包。

- 微软官方中文语言包不管 Copilot（它是 Marketplace 扩展），本包补的就是界面这一层。
- Copilot 自带的 `localeOverride: "zh-CN"` 只让聊天**回答**变中文，不管界面；本包翻的是界面（命令、聊天面板、通知、报错等）。
- Chat 清单层 456 条 + 运行时 255 条，核心扩展 19 条命令标题。
- 基于 Copilot 1.388.0 / Copilot Chat 0.48.1。只含翻译字符串，不含 Copilot 代码。
- 详见 [`copilot-zh-cn/README.md`](copilot-zh-cn/README.md)。

### Grokbot 开源平替精选 —— [`grokbot/GROKBOT.md`](grokbot/GROKBOT.md)

没有官方开源的 Grok Bot（xAI 的是闭源产品），这里收的是 GitHub 上最好的开源平替：

- **OpenMausBot**（22.9k★，首选）：本地优先的 Grok Bot 平替，TypeScript/MIT。
- **DeepSeekBot**（860★）：基于 DeepSeek Harness，支持微信/QQ/Discord。
- 以及 gawkbot、celesto、grokbot-clone，和 awesome-grokbot、grokbot-field-notes 两个参考资料。

## 许可

各子目录以其自身许可为准（翻译内容 MIT）。
