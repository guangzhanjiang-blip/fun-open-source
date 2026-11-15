# Grokbot —— 开源平替精选

先说一个关键事实：**没有官方开源的 Grok Bot**。Grok Bot 是 xAI 的闭源托管产品，没有公开仓库。下面是 GitHub 上最好的开源平替/克隆版（2026-11-15 收录，星数与更新时间为当日快照）。

## 首选

### 1. OpenMausBot ⭐ 22,942

- 仓库：https://github.com/milind-soni/OpenMausBot
- 语言：TypeScript ｜ 许可：MIT
- 是什么：本地优先的 Grok Bot 平替。聊天应用里侧边栏的每个机器人都是真实 AI 智能体（Claude、Codex 或 Grok），跑在你自己电脑上，各有性格、模型、记忆和一台能干活的“虚拟电脑”。
- 怎么跑：克隆后本地运行，用自己的 API Key（支持 Grok）。
- 为什么收：星数断层第一、功能最完整、持续维护；还有中文 fork（OpenMausBot-cn），和本仓库的汉化方向很搭。

### 2. DeepSeekBot ⭐ 860

- 仓库：https://github.com/BotHarness/DeepSeekBot
- 语言：TypeScript ｜ 许可：MIT
- 是什么：基于 DeepSeek Harness 的开源 GrokBot 平替：多 Bot 团队、长期记忆、身份权限、插件扩展；支持 Discord、飞书、QQ、Slack、**微信**机器人。
- 怎么跑：基于 DeepSeek Harness（DSH）运行。
- 为什么收：和已装好的 DSH 直接配套，落地最顺；支持微信/QQ，对中文用户最友好。
- 注意：项目很新（2026-09 创建），open issue 有 447 个，成熟度不如 OpenMausBot。

## 其他值得看的

### 3. gawkbot ⭐ 1,575

- 仓库：https://github.com/najmuzzaman-mohammad/gawkbot
- 语言：Go
- 是什么：字面意义上的“开源 grok bot”：机器人用 AI 模型自动干杂活，还能给你生成管理结果的小应用（microapps），支持本地大模型、自托管。

### 4. celesto ⭐ 1,383

- 仓库：https://github.com/CelestoAI/celesto
- 语言：Python
- 是什么：给 AI 智能体用的“安全持久电脑”（沙箱/运行时），偏基础设施，不是聊天机器人本体，适合想自己搭机器人底座时用。

### 5. grokbot-clone ⭐ 221

- 仓库：https://github.com/nickvasilescu/grokbot-clone
- 语言：TypeScript
- 是什么：字面克隆版：用真正的 Grok API + Orgo 云电脑 + Composio 做常驻 AI 队友（声明与 xAI 无关）。非常新（2026-11-09 创建），但更新活跃。
- 需要：Grok API Key + Orgo/Composio。

## 参考资料（不是能跑的机器人）

- **awesome-grokbot**（498★）：https://github.com/kydlikebtc/awesome-grokbot —— 1,894 个 Grok Bot 作品分享链接目录，中英双语，可当资源清单。
- **grokbot-field-notes**（709★）：https://github.com/unicodef1wn/grokbot-field-notes —— xAI Grok Bot 团队 72 小时实战的规则/手册/失败记录，放个 AGENTS.md 就能用，适合当玩法参考。

## 收录标准

能自己跑、有持续维护、和 Grok Bot“常驻 AI 队友”这个定位相关。更大的通用智能体框架（如 OpenClaw、Hermes Agent）不在此列。
