# CoolerHermes

**Hermès and Ultra watch faces on the Apple Watch you already own.**

Apple keeps those faces locked to hardware you have to pay extra for. CoolerHermes unlocks them from your iPhone. You don't need a jailbreak or a paid developer account, and a free Apple ID is enough.

## What you get

- Hermès faces on any supported Apple Watch
- Ultra faces on any supported Apple Watch
- Siri AI for US-region setups
- A switch for each feature, so you only change what you want
- A backup saved before every change, with one-tap restore
- A raw key editor for anything the switches don't cover

## How it works

1. Install CoolerHermes on your iPhone.
2. Install the small helper on your Apple Watch.
3. Open the app, link your watch, flip the faces you want.
4. Tap Apply. The watch reloads and the faces are there.

## Before you start

- iPhone running iOS or iPadOS 26 or newer
- An Apple Watch on a supported watchOS release
- Developer Mode turned on, on both devices
- Any sideloading tool that signs with a free Apple ID

## Setup guide

**iPhone**

Grab `CoolerHermes.ipa` from the Releases page, sign it with your sideloading tool, and install it. Then open Settings → General → VPN & Device Management and trust your certificate.

**Apple Watch**

The helper has to be trusted separately on the watch, so repeat the trust step there too. We use WatchBridge to push the iPhone app and the watch helper together. It's a community tool and not part of this project.

After that, open CoolerHermes, expand the device card at the top, connect your watch, and you're set.

## Good to know

- Free Apple ID accounts allow a few sideloaded apps at once. If install fails with a limit error, remove one old app and retry.
- The backup is made automatically. Restore it from inside the app before you ever delete CoolerHermes.
- CoolerHermes isn't affiliated with or endorsed by Apple or Hermès. You use it at your own risk.

## Credits and license

Built on [GestaltEdit](https://github.com/frs0n/GestaltEdit) and the open-source work behind it, modified (see git history). Full notices are in `LICENSE` and the bundled license files.

CoolerHermes is released under the [GNU General Public License v3.0 or later](LICENSE).
