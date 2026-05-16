# homebrew-twilight

Homebrew tap for [Twilight](https://github.com/thegoatsmith/twilight) — a tiny
macOS menu-bar utility that switches the system between Light and Dark mode at
sunrise and sunset.

## Install

```sh
brew tap thegoatsmith/twilight
brew install --build-from-source twilight
ln -sfn "$(brew --prefix)/opt/twilight/Twilight.app" /Applications/Twilight.app
```

The formula builds from source on your machine — no Apple Developer signing or
notarization needed. Requires Xcode (full Xcode, not just the Command Line
Tools, since this is a SwiftUI app).

## Upgrade

```sh
brew update
brew upgrade --build-from-source twilight
```

## Uninstall

```sh
brew uninstall twilight
brew untap thegoatsmith/twilight
rm -f /Applications/Twilight.app   # only if you symlinked it
```

## Releases

This tap is bumped automatically by a GitHub Actions workflow on the main
[Twilight](https://github.com/thegoatsmith/twilight) repo: every `v*` tag push
opens a PR here updating `url` and `sha256`.

## License

MIT — see [LICENSE](https://github.com/thegoatsmith/twilight/blob/main/LICENSE)
in the main repo.
