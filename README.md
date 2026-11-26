<p align="center">
  <b>简体中文</b> · <a href="README.en.md">English</a>
</p>

<h1 align="center">DS Pro</h1>

<p align="center">
  DeepSeek Harness 的手机应用 —— 基于 <a href="https://github.com/ccch1mneyyy/dsh-Go">DSH Go</a> 精简改制的<strong>本机运行版</strong>，聚焦「装在手机上、自己跑引擎」这一个用法。
</p>

<p align="center">
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="Android 8+" src="https://img.shields.io/badge/Android-8%2B-4B67B4?style=flat-square&logo=android&logoColor=white&labelColor=2B3245"></a>
  <a href="LICENSE"><img alt="许可证 AGPL-3.0" src="https://img.shields.io/badge/%E8%AE%B8%E5%8F%AF%E8%AF%81-AGPL--3.0-4B67B4?style=flat-square&labelColor=2B3245"></a>
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="最新版 v1.3.0" src="https://img.shields.io/badge/%E6%9C%80%E6%96%B0%E7%89%88-v1.3.0-4B67B4?style=flat-square&labelColor=2B3245"></a>
</p>

<br>

<a id="download"></a>
<h3 align="center">下载 DS Pro</h3>

<p align="center">从 GitHub Releases 获取最新版 APK。常见 64 位 Android 手机选 <b>arm64</b> 包；当前仅提供 Android 版。</p>

<p align="center">
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="从 GitHub Releases 下载" src="https://img.shields.io/badge/GitHub%20Releases-%E4%B8%8B%E8%BD%BD%20APK-4B67B4?style=for-the-badge&logo=github&logoColor=white&labelColor=2B3245"></a>
</p>

<p align="center">
  <sub>手机上装过签名不同的旧包时不能直接覆盖安装，需要先卸载旧版；卸载会清空对话、Linux 环境和设置。</sub>
</p>

<br>

## 本机运行，不依赖电脑

内置 Linux 环境，免 Root、免 Termux。在手机本地安装 Ubuntu、Node.js 与 DSH 运行环境，模型请求由你配置的模型提供方处理。首次启动只有「本机 / 酒馆」两种选择，不再有远程主机。

<br>

<h3 align="center">插话、打断，过程自动收好</h3>

<p align="center">回复中途也能插话，排队的消息随时「立即发送」。做完的过程折叠成一行。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-steer-zh-dark.webp">
    <img src="docs/assets/f-steer-zh-light.webp" width="100%" alt="生成中排队一条消息；完成后过程折叠">
  </picture>
</p>

<br>

<h3 align="center">原生界面，也有网页版</h3>

<p align="center">和官方网页版一键切换，停在同一段对话，下次打开还是你上次用的那个。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-web-zh-dark.webp">
    <img src="docs/assets/f-web-zh-light.webp" width="100%" alt="同一段对话的原生界面与网页版">
  </picture>
</p>

<br>

<h3 align="center">分享卡、对话回放和链接</h3>

<p align="center">回复一键做成分享卡。整段对话生成链接，对方在浏览器里回放，链接端到端加密。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-share-zh-dark.webp">
    <img src="docs/assets/f-share-zh-light.webp" width="100%" alt="分享卡、对话回放、我的分享链接">
  </picture>
</p>

<br>

<h3 align="center">本地备份与恢复</h3>

<p align="center">对话一键备份成单个文件，换机或重置后原样恢复 —— 备份直接读写引擎的会话目录，不是重新编码。</p>

<br>

<h3 align="center">全局用量与花费</h3>

<p align="center">本机所有对话汇总成一张表：token 用量与按 DeepSeek 公开价格估算的花费，一目了然（估算值，价格以官方为准）。</p>

<br>

<h3 align="center">横屏与平板</h3>

<p align="center">横屏手机和平板重新排版：侧栏常驻，内容居中，弹出键盘也不挤。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-adaptive-zh-dark.webp">
    <img src="docs/assets/f-adaptive-zh-light.webp" width="100%" alt="平板与横屏手机">
  </picture>
</p>

<br>

<h3 align="center">主题配色与桌面图标</h3>

<p align="center">六套主题色，也能跟随壁纸或自选颜色。四款桌面图标，三种功能图标风格。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-theme-zh-dark.webp">
    <img src="docs/assets/f-theme-zh-light.webp" width="100%" alt="主题设置与两种主题色">
  </picture>
</p>

<br>

<h3 align="center">中文，也说 English</h3>

<p align="center">全部界面支持英文，在设置里切换，默认跟随系统。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-lang-dark.webp">
    <img src="docs/assets/f-lang-light.webp" width="100%" alt="同一段对话的中文与英文界面">
  </picture>
</p>

<br>

<h3 align="center">手机操控</h3>

<p align="center">看屏幕、帮你点，三档确认随你选。敏感操作默认交还给你；放宽应用规则或解除限制前，请先了解风险。</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-phone-zh-dark.webp">
    <img src="docs/assets/f-phone-zh-light.webp" width="100%" alt="手机操控与确认方式">
  </picture>
</p>

<br>

## 可以做什么

DS Pro 是 [DSH Go](https://github.com/ccch1mneyyy/dsh-Go) 的精简**本机运行版**，基于 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) 构建。运行在手机上的是 DSH 引擎；模型请求仍由你配置的模型提供方处理。

- **本机运行**：在 App 内安装 Ubuntu、Node.js 与 DSH 运行环境，无需 Root 或另装 Termux；只保留「本机 / 酒馆」两种用法，不依赖电脑或服务器。
- **聊天与工具**：切换模型，发送图片、使用语音输入，处理工具审批和提问；支持聊天界面与网页模式。
- **插件界面**：使用适配 DSH Go 的原生工具卡、表单和面板；仓库提供 SDK、教程和示例。
- **手机操控**：在你开启权限后，让本机引擎读取屏幕、点按和输入，并可随时停止。
- **分享与外观**：分享、导出和回放对话，调整主题、图标和桌宠。
- **本地备份**：对话一键备份成单个文件，可随时恢复。
- **全局用量**：汇总本机所有对话的 token 用量与估算花费。

## 相比 DSH Go 精简了什么

DS Pro 只保留「本机运行」这件事，去掉了远程相关的入口与功能：

- **删除** 远程主机 / SSH / 中继（不再有「遥控电脑」）
- **删除** 伙伴小屋与伙伴全部界面
- **删除** 创意工坊与「让 AI 做一只宠物」
- **删除** 设置 → 远程主机、隐私与分享 →「改进 DSH Go」
- 设置 → 帮助与关于只保留「诊断」入口

同时**新增**：本地备份与恢复、全局用量与花费、支持页（致谢）。

## 安装

安装要求为 Android 8.0（API 26）及以上。Release 页面上的 **arm64** 安装包适用于常见的 64 位 Android 手机；当前仓库没有 x86_64 或 32 位 ARM 构建。

1. 从 [GitHub Releases](https://github.com/lijiyang2007/ds-pro/releases/latest) 下载对应架构的 APK，并按系统提示允许该安装来源。
2. 首次启动时选择在本机安装运行环境（或「酒馆」模式）。
3. 为所选模型提供方配置模型和所需凭据，再开始对话。

首次使用建议预留约 1 GB 空间用于安装本机运行环境。本地引擎默认使用 PRoot 兼容启动。

## 数据与权限

模型请求会发送给你配置的提供方。开启手机操控后，任务需要的屏幕文字可能发送给模型，支持看图的模型也可能收到截图；请先阅读 App 的权限说明。

“发送匿名使用统计”默认开启，可在首次引导或“设置 → 隐私与分享”关闭。分享内容前，请检查预览；收到链接或文件的人可以保存其中的内容。

## 风险提示与免责声明

DS Pro 是社区开发的非官方项目，与 DeepSeek 无关联，也不代表 DeepSeek。使用前请了解：

- **AI 并非万无一失**：回答、代码和操作可能出错，也可能被网页、消息或文件中的恶意指令误导。请核验重要结果；医疗、法律、投资等高风险决策不应仅依赖 AI 输出。
- **工具会产生真实影响**：本机上的命令、文件修改及手机操控可能导致数据丢失、隐私泄露、账号、资金或设备损失。免确认、放宽应用规则或解除限制会减少保护；确认与拦截机制不能保证消除所有风险。建议保留默认保护，只授予必要权限，不在存有支付或银行信息的设备上解除限制。
- **第三方服务与费用**：模型、插件等按各自条款运行；相关数据处理、服务可用性和费用取决于你选择的服务与配置。本机运行不等于模型离线，也不代表数据不会离开设备。
- **使用前做好防护**：备份重要数据，只安装可信插件，留意模型用量与费用；不要让 AI 无人值守地处理不可逆或高风险任务。
- **无担保与责任范围**：在适用法律允许的范围内，本软件按“现状”提供，不保证准确性、持续可用性或满足特定用途；相关无担保及责任限制见 [LICENSE](LICENSE) 第 15–17 条。本声明不排除或限制依法不得排除或限制的责任，也不减损你依法享有的权利。

## 常见问题

<details>
<summary><b>和 DeepSeek 官方是什么关系？</b></summary>
<br>

没有关系。DS Pro 是社区开发的非官方客户端，基于开源的 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness) 构建。手机上运行的是 DSH 本身；模型请求发给你配置的模型提供方，需要联网，按你在提供方的账户计费。

</details>

<details>
<summary><b>安全吗？</b></summary>
<br>

本机网页版只接受 App 自己的访问。分享链接端到端加密，密钥只在链接里，服务器看不到内容，但获得完整链接的人可以读取并保存内容。手机操控默认保留敏感操作保护；放宽应用规则或开启「解除限制」会减少这些保护。安全机制不能保证零风险，详见[风险提示与免责声明](#风险提示与免责声明)。

</details>

<details>
<summary><b>切到后台会被杀吗？</b></summary>
<br>

部分系统的省电策略会拦住后台。DS Pro 发现后会提醒你，并直达对应的放行设置，vivo、小米、华为、荣耀、OPPO 都有。

</details>

<details>
<summary><b>对手机有什么要求？</b></summary>
<br>

Android 8 及以上。手机直接下载 Release 页面上的安装包即可。在手机上运行 DSH 要先准备内置的运行环境，请预留约 1 GB 空间。

</details>

<details>
<summary><b>开源吗？</b></summary>
<br>

开源，代码就在这个仓库，以 [AGPL-3.0](LICENSE) 发布，`sdk/` 和 `examples/` 为 MIT。DS Pro 的名称和标识基于上游 DSH Go 样式；Deepy、鲸娘两位吉祥物不在开源授权范围内，见 [ASSETS.md](ASSETS.md)。

</details>

## 从源码构建

以下流程面向 **Linux x86_64**。当前工具链脚本默认安装 JDK 17、Flutter 3.47.7 和 Android SDK/NDK；App 要求 Dart `^3.13.5`。准备 Bash、Git、curl、tar、unzip、xz、Python 3、zstd（Python 未提供 `compression.zstd` 时用于解包 zstd 压缩的 deb）、file 和常见 GNU 命令。

先取得完整源码和项目资源。`app/pubspec.yaml` 声明的字体、图片等都是构建输入，运行时包由下面的脚本生成。

```bash
git clone https://github.com/lijiyang2007/ds-pro.git
cd ds-pro

bash tooling/setup-toolchain.sh
source tooling/env.sh
flutter --version
java -version

bash runtime/build-runtime.sh arm64-v8a
DSH_BETA_TOKEN_FILE= bash tooling/build-apk.sh -f arm64 --keep-daemon
```

工具链脚本会下载 SDK/NDK 与模拟器镜像，并执行 Android SDK 许可接受步骤。默认安装到 `~/dev`；可通过 `DEV_ROOT` 指定独立目录。脚本会复用已有安装，构建前请核对版本。

产物为 `app/build/app/outputs/flutter-apk/app-arm64-release.apk`。运行时构建使用仓库固定的版本与校验信息，并需要联网下载依赖。示例中的 `DSH_BETA_TOKEN_FILE=` 不嵌入维护者的内测通道令牌；`--keep-daemon` 保留 Gradle daemon，适合同时开发其他 Android 项目的环境。

未配置 `app/android/key.properties` 时，本地 release 构建使用 debug 签名。它不能直接覆盖不同签名的官方安装包；请在测试设备上安装，保留已有数据，不要为解决签名冲突直接卸载正在使用的 App。发布签名与密钥文件不要提交到仓库。

## 目录

| 路径 | 内容 |
| --- | --- |
| `app/` | Flutter 界面与 Android Kotlin 实现 |
| `packages/dsh_client/` | DSH Web API 的 Dart 客户端 |
| `packages/dsh_remote/` | DSH Remote 的 Dart 客户端 |
| `runtime/` | Android Linux 运行时、引擎补丁与 App 桥接 |
| `sdk/plugin-kit/` | 原生插件作者工具包；在仓库中使用，未发布到 npm |
| `examples/plugins/` | 插件示例 |
| `docs/` | 架构、用户指南与插件文档 |
| `tooling/` | 工具链、Android APK 开发构建与诊断脚本 |

## 参与贡献

问题反馈和改进建议可提交到 [Issues](https://github.com/lijiyang2007/ds-pro/issues)。代码、文档和翻译贡献请先看 [CONTRIBUTING.md](CONTRIBUTING.md)。

安全问题请按 [SECURITY.md](SECURITY.md) 报告，避免在公开 Issue 中提交漏洞细节或凭据。

## 来源与致谢

DS Pro 是 [DSH Go](https://github.com/ccch1mneyyy/dsh-Go) 的 fork 精简版，代码以 [AGPL-3.0](LICENSE) 开源。改造时遵循上游的协作要求：

- **标注主仓库与作者**：基于上游改造时，在仓库说明、应用「关于」页和发布页面标注主仓库 <https://github.com/ccch1mneyyy/dsh-Go> 与原作者 [ccch1mneyyy](https://github.com/ccch1mneyyy)，并按适用许可证保留版权、许可及修改声明。
- **名称与素材另有限制**：DSH Go 的名称、标识，以及 Deepy、鲸娘形象不在 AGPL 授权范围内，以修改版身份发布时请换成自己的名称和素材，见 [ASSETS.md](ASSETS.md)。

**许可说明**：AGPL-3.0 允许符合其条款的修改、再发布和商业使用；上述署名位置是作者的协作请求，不是对代码许可证追加的限制。品牌与素材须遵守各自的授权条件；本说明不改变 `sdk/`、`examples/` 及第三方内容的许可。

## 许可证与致谢

本项目采用 [AGPL-3.0](LICENSE)；`sdk/` 和 `examples/` 保持 **MIT**。第三方代码和素材以各自声明为准。

- [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)：DS Pro 运行和连接的就是它。
- [DSH Go](https://github.com/ccch1mneyyy/dsh-Go)：DS Pro 的上游项目。

DeepSeek Harness、DSH Go 及其他第三方组件、素材保留各自的许可证和署名。具体来源和条款见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

<br>

<p align="center"><sub>DS Pro 是社区开发的非官方客户端，与 DeepSeek 没有关联，也不代表 DeepSeek。DeepSeek 名称与标识归其所有者所有。</sub></p>