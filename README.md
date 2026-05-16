# homebrew-twilight

Homebrew tap for [Twilight](https://github.com/thegoatsmith/twilight) — a tiny
macOS menu-bar utility that switches the system between Light and Dark mode at
sunrise and sunset.

## Install

```sh
brew tap thegoatsmith/twilight
brew install --build-from-source twilight
twilight
```

`brew install` builds from source (~15s) and installs a `twilight` command on
your PATH that launches the app. No Apple Developer signing or notarization
needed. Requires full Xcode (not just Command Line Tools) since this is a
SwiftUI app.

**Optional — for Spotlight / Launchpad / Dock integration**, symlink it into
`/Applications` once:

```sh
ln -sfn "$(brew --prefix)/opt/twilight/Twilight.app" /Applications/Twilight.app
```

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
