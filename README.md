# About

**A lightweight and simple base structure for games, using *[Heaps](https://heaps.io)* framework  and *[Haxe](https://haxe.org)* language.**

Latest release notes: [View changelog](CHANGELOG.md).

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/deepnight/gameBase/Test%20JS%20build)](https://github.com/deepnight/gameBase/actions)

# Install

 1. Install **Haxe** and **Hashlink**: [Step-by-step tutorial](https://deepnight.net/tutorial/a-quick-guide-to-installing-haxe/)
 2. Install required libs by running the following command **in the root of the repo**: `haxe setup.hxml`

# Compile

From the command line, run either:

 - For **DirectX**: `haxe build.directx.hxml`
 - For **OpenGL**: `haxe build.opengl.hxml`
 - For **Javascript/WebGL**: `haxe build.js.hxml`

Run the result with either:

 - For **DirectX/OpenGL**: `hl bin\client.hl`
 - For **Javascript**: `start run_js.html`

# Full guide

An in-depth tutorial is available here: [Using gamebase to create a game](https://deepnight.net/tutorial/using-my-gamebase-to-create-a-heaps-game/).

For **localization support** (ie. translating your game texts), you may also check the [following guide](https://deepnight.net/tutorial/part-4-localize-texts-using-po-files/).

Any question? Join the [Official Deepnight Games discord](https://deepnight.net/go/discord).

# Cleanup for your own usage

You may remove the following files/folders from repo root:

- `.github`
