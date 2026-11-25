<p align="center">
  <a href="README.md">简体中文</a> · <b>English</b>
</p>

<h1 align="center">DS Pro</h1>

<p align="center">
  A mobile app for DeepSeek Harness — a <strong>local-only</strong> streamlined build based on <a href="https://github.com/ccch1mneyyy/dsh-Go">DSH Go</a>, focused on the single use case of "run the engine right on your phone".
</p>

<p align="center">
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="Android 8+" src="https://img.shields.io/badge/Android-8%2B-4B67B4?style=flat-square&logo=android&logoColor=white&labelColor=2B3245"></a>
  <a href="LICENSE"><img alt="License AGPL-3.0" src="https://img.shields.io/badge/license-AGPL--3.0-4B67B4?style=flat-square&labelColor=2B3245"></a>
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="Latest v1.3.0" src="https://img.shields.io/badge/latest-v1.3.0-4B67B4?style=flat-square&labelColor=2B3245"></a>
</p>

<br>

<a id="download"></a>
<h3 align="center">Download DS Pro</h3>

<p align="center">Get the latest APK from GitHub Releases. For most 64-bit Android phones, choose the <b>arm64</b> package; only Android is available at the moment.</p>

<p align="center">
  <a href="https://github.com/lijiyang2007/ds-pro/releases/latest"><img alt="Download APK from GitHub Releases" src="https://img.shields.io/badge/GitHub%20Releases-Download%20APK-4B67B4?style=for-the-badge&logo=github&logoColor=white&labelColor=2B3245"></a>
</p>

<p align="center">
  <sub>If you have an older test build with a different signature installed, you cannot install over it directly — uninstall the old version first. Uninstalling clears conversations, the Linux environment, and settings.</sub>
</p>

<br>

## Runs locally, no computer needed

A built-in Linux environment — no root, no Termux. Install Ubuntu, Node.js, and the DSH runtime locally on your phone; model requests are handled by whichever model provider you configure. First-run offers only two paths — **local** or **tavern** — with no remote hosts.

<br>

<h3 align="center">Interrupt, steer, and auto-collapse</h3>

<p align="center">Interrupt mid-reply, queue a message to send with one tap ("send now"). Finished steps collapse into a single line.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-steer-en-dark.webp">
    <img src="docs/assets/f-steer-en-light.webp" width="100%" alt="Queue a message mid-generation; finished steps collapse">
  </picture>
</p>

<br>

<h3 align="center">Native UI, plus the web view</h3>

<p align="center">Switch to the official web view with one tap, staying on the same conversation; next time you open the app it is still there.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-web-en-dark.webp">
    <img src="docs/assets/f-web-en-light.webp" width="100%" alt="The same conversation in native UI and the web view">
  </picture>
</p>

<br>

<h3 align="center">Share cards, replays and links</h3>

<p align="center">Turn a reply into a share card with one tap. Generate a link for a whole conversation that others can replay in a browser — end-to-end encrypted.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-share-en-dark.webp">
    <img src="docs/assets/f-share-en-light.webp" width="100%" alt="Share cards, conversation replay, shared links">
  </picture>
</p>

<br>

<h3 align="center">Local backup &amp; restore</h3>

<p align="center">Back up your conversations to a single file and restore them intact after switching devices or a reset — the backup reads and writes the engine's own session directory, not a re-encoding.</p>

<br>

<h3 align="center">Global usage &amp; spend</h3>

<p align="center">Every conversation on this device, added up: token usage and an estimated cost at DeepSeek's published prices, at a glance (an estimate — prices change, official prices apply).</p>

<br>

<h3 align="center">Landscape &amp; tablets</h3>

<p align="center">Re-laid out for landscape phones and tablets: sidebar always visible, content centered, and the keyboard does not crowd the view.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-adaptive-en-dark.webp">
    <img src="docs/assets/f-adaptive-en-light.webp" width="100%" alt="Tablets and landscape phones">
  </picture>
</p>

<br>

<h3 align="center">Themes &amp; launcher icons</h3>

<p align="center">Six theme colors, or follow your wallpaper or pick your own. Four launcher icons and three icon styles for features.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-theme-en-dark.webp">
    <img src="docs/assets/f-theme-en-light.webp" width="100%" alt="Theme settings and two theme colors">
  </picture>
</p>

<br>

<h3 align="center">中文，也说 English</h3>

<p align="center">The whole UI supports English; switch in Settings, and it follows the system by default.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-lang-dark.webp">
    <img src="docs/assets/f-lang-light.webp" width="100%" alt="The same conversation in Chinese and English">
  </picture>
</p>

<br>

<h3 align="center">Phone control</h3>

<p align="center">See the screen and tap for you; pick from three confirmation levels. Sensitive operations are handed back to you by default — understand the risks before relaxing app rules or removing limits.</p>

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/assets/f-phone-en-dark.webp">
    <img src="docs/assets/f-phone-en-light.webp" width="100%" alt="Phone control and confirmation levels">
  </picture>
</p>

<br>

## What you can do

DS Pro is a streamlined **local-only** build of [DSH Go](https://github.com/ccch1mneyyy/dsh-Go), built on [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness). The DSH engine runs on your phone; model requests are still handled by whichever model provider you configure.

- **Run locally**: install Ubuntu, Node.js, and the DSH runtime inside the app — no root, no Termux. Only two first-run paths remain: **local** or **tavern**; no computer or server required.
- **Chat & tools**: switch models, send images, use voice input, handle tool approvals and questions; both the chat UI and the web mode are available.
- **Plugin UI**: native tool cards, forms and panels built for DSH Go; the repo ships the SDK, tutorials and examples.
- **Phone control**: once you grant permission, let the local engine read the screen, tap and type, and stop it any time.
- **Share & appearance**: share, export and replay conversations; adjust themes, icons and the desktop pet.
- **Local backup**: back conversations up to a single file and restore them anytime.
- **Global usage**: aggregate token usage and estimated spend across every conversation on this device.

## What was trimmed compared to DSH Go

DS Pro keeps only the "local runtime" use case and removes everything remote-related:

- **Removed** remote hosts / SSH / relay (no more "remote-control your computer")
- **Removed** the companion cottage and all companion UI
- **Removed** the workshop and "make an AI pet"
- **Removed** Settings → Remote hosts and Privacy & sharing → "Improve DSH Go"
- Settings → Help & About now keeps only the "Diagnostics" entry

**Added**: local backup & restore, global usage & spend, and support pages (donate / credits).

## Installation

Requires Android 8.0 (API 26) or later. The **arm64** package on the Releases page fits common 64-bit Android phones; there is currently no x86_64 or 32-bit ARM build in this repo.

1. Download the APK for your architecture from [GitHub Releases](https://github.com/lijiyang2007/ds-pro/releases/latest) and allow that install source when prompted.
2. On first launch, choose to install the runtime locally (or "tavern" mode).
3. Configure the model and credentials for your chosen provider, then start chatting.

Allow roughly 1 GB of space for the local runtime on first use. The local engine starts with PRoot compatibility by default.

## Data & permissions

Model requests are sent to the provider you configure. After you enable phone control, on-screen text may be sent to the model and screenshot-capable models may receive screenshots; please read the app's permission notices first.

"Send anonymous usage statistics" is on by default; you can turn it off in first-run setup or in Settings → Privacy & sharing. Check the preview before sharing; anyone with the link or file can save its contents.

## Risks & disclaimer

DS Pro is a community-developed unofficial project with no affiliation to DeepSeek, and does not represent DeepSeek. Please understand the following before use:

- **AI is not infallible**: answers, code, and actions can be wrong, and malicious instructions in pages, messages, or files can mislead it. Verify important results; high-stakes decisions in medicine, law, investment, and similar fields should not rely on AI output alone.
- **Tools have real impact**: commands, file changes and phone control on this device can cause data loss, privacy leaks, or loss of accounts, funds or equipment. Disabling confirmations, relaxing app rules, or removing limits reduces protection; confirmation and interception mechanisms cannot guarantee zero risk. Keep the default protections, grant only necessary permissions, and do not remove limits on a device holding payment or banking information.
- **Third-party services and costs**: models and plugins run under their own terms; data handling, availability and costs depend on the services and configuration you choose. Running locally is not the same as being offline, and does not mean data never leaves your device.
- **Protect yourself before use**: back up important data, install only trusted plugins, and watch model usage and cost; do not leave AI unattended on irreversible or high-risk tasks.
- **No warranty and limitation of liability**: to the extent permitted by applicable law, this software is provided "as is" without warranties of accuracy, continuous availability, or fitness for a particular purpose; see [LICENSE](LICENSE) sections 15–17. This statement does not exclude or limit liability that cannot be excluded or limited by law, nor diminish your legal rights.

## FAQ

<details>
<summary><b>What is the relationship with DeepSeek?</b></summary>
<br>

None. DS Pro is a community-developed unofficial client built on the open-source [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness). What runs on your phone is DSH itself; model requests go to the model provider you configure, need network access, and are billed on your account with that provider.

</details>

<details>
<summary><b>Is it safe?</b></summary>
<br>

The local web view only accepts access from the app itself. Shared links are end-to-end encrypted — the key lives only in the link and the server cannot see the content — but anyone with the full link can read and save it. Phone control keeps sensitive-operation protection on by default; relaxing app rules or enabling "remove limits" reduces that protection. No security mechanism can guarantee zero risk; see [Risks & disclaimer](#risks--disclaimer) for details.

</details>

<details>
<summary><b>Will it be killed in the background?</b></summary>
<br>

Some systems' power-saving policies block background activity. DS Pro detects this, reminds you, and jumps straight to the relevant whitelist setting — vivo, Xiaomi, Huawei, Honor and OPPO are all covered.

</details>

<details>
<summary><b>What are the phone requirements?</b></summary>
<br>

Android 8 or later. Just download the installer from the Releases page. Running DSH on your phone needs the built-in runtime prepared first; allow roughly 1 GB of space.

</details>

<details>
<summary><b>Is it open source?</b></summary>
<br>

Yes. The code lives in this repository, released under [AGPL-3.0](LICENSE), with `sdk/` and `examples/` under MIT. DS Pro's name and identity derive from the upstream DSH Go style; the Deepy and 鲸娘 mascots are not covered by the open-source license — see [ASSETS.md](ASSETS.md).

</details>

## Building from source

The following flow targets **Linux x86_64**. The toolchain scripts install JDK 17, Flutter 3.47.7 and the Android SDK/NDK by default; the app requires Dart `^3.13.5`. You need Bash, Git, curl, tar, unzip, xz, Python 3, zstd (when Python lacks `compression.zstd`, used to unpack zstd-compressed deb files), file and common GNU utilities.

First get the full source and project assets. The fonts and images declared in `app/pubspec.yaml` are build inputs; runtime packages are generated by the scripts below.

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

The toolchain scripts download the SDK/NDK and emulator images and accept the Android SDK licenses. The default install location is `~/dev`; use `DEV_ROOT` to specify another directory. Scripts reuse existing installs — check versions before building.

The output is `app/build/app/outputs/flutter-apk/app-arm64-release.apk`. The runtime build uses fixed versions and checksums from the repo and needs network access for dependencies. `DSH_BETA_TOKEN_FILE=` in the example keeps the maintainer's beta-channel token out; `--keep-daemon` keeps the Gradle daemon, handy when developing other Android projects on the same machine.

Without `app/android/key.properties`, local release builds use the debug signature. It cannot overwrite a different-signed official package; install it on a test device and keep existing data — do not uninstall a working app to resolve a signature conflict. Do not commit release signing keys or keystore files.

## Layout

| Path | Contents |
| --- | --- |
| `app/` | Flutter UI and the Android Kotlin implementation |
| `packages/dsh_client/` | Dart client for the DSH Web API |
| `packages/dsh_remote/` | Dart client for DSH Remote |
| `runtime/` | Android Linux runtime, engine patches and app bridge |
| `sdk/plugin-kit/` | Toolkit for native plugin authors; used in-repo, not published to npm |
| `examples/plugins/` | Plugin examples |
| `docs/` | Architecture, user guide and plugin docs |
| `tooling/` | Toolchain, Android APK dev-build and diagnostics scripts |

## Contributing

Issues and suggestions are welcome at [Issues](https://github.com/lijiyang2007/ds-pro/issues). For code, docs and translations, please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

Report security issues per [SECURITY.md](SECURITY.md), and do not post vulnerability details or credentials in public issues.

## Origin & credits

DS Pro is a forked, streamlined build of [DSH Go](https://github.com/ccch1mneyyy/dsh-Go), open-sourced under [AGPL-3.0](LICENSE). Following the upstream author's collaboration requests:

- **Credit the upstream repo and author**: when distributing a derivative, mark the upstream repo <https://github.com/ccch1mneyyy/dsh-Go> and the original author [ccch1mneyyy](https://github.com/ccch1mneyyy) in the repo description, the app's About page and the release page, and keep the applicable license, copyright and modification notices.
- **Names & assets have extra limits**: the DSH Go name and identity, and the Deepy and 鲸娘 mascots are not covered by AGPL; when publishing a modified build, use your own name and assets — see [ASSETS.md](ASSETS.md).

**License note**: AGPL-3.0 permits modification, redistribution and commercial use under its terms; the credit-request above is a collaboration ask from the author, not an extra restriction on the code license. Brands and assets follow their own terms; this note does not change the licensing of `sdk/`, `examples/` or third-party content.

## License & acknowledgements

This project is licensed under [AGPL-3.0](LICENSE); `sdk/` and `examples/` remain **MIT**. Third-party code and assets follow their own notices.

- [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness): what DS Pro runs and connects to.
- [DSH Go](https://github.com/ccch1mneyyy/dsh-Go): the upstream project of DS Pro.

DeepSeek Harness, DSH Go and other third-party components and assets retain their own licenses and credits. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for details.

<br>

<p align="center"><sub>DS Pro is a community-developed unofficial client with no affiliation to DeepSeek and does not represent DeepSeek. The DeepSeek name and logo belong to their respective owners.</sub></p>