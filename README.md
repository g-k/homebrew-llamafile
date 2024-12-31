This is an unofficial Homebrew custom tap to install https://github.com/Mozilla-Ocho/llamafile for OSX on Arm64.


First:

```sh
brew tap g-k/homebrew-llamafile
```

Then run:

```sh
brew install llamafile
```

to install the `llamafile` command.

Or add `--with-extras` to install the other binaries like `whisperfile`:

```sh
brew install --with-extras llamafile
```

Note: llamafiles can also be run directly.


To uninstall:

```sh
brew uninstall llamafile
```

```sh
brew untap g-k/homebrew-llamafile
```