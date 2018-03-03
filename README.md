# orchestra

> CybreDisk build system

## Install

```sh
$ git clone https://github.com/CybreDisk/orchestra.git
```

## Usage

Add repositories to the `repositories` file.

Then, from the Orchestra folder run:

```sh
$ ./make.sh
```

This will create a file system in `$PREFIX`, which defaults to the `prefix` folder in the Orchestra folder.

## Pre- and post-build scripts

If you want, you may add pre- and post-build actions to a script. Set variables `PREBUILD` and `POSTBUILD`, which respectively default to `{pre,post}-build.sh` in the Orchestra folder.

The scripts only get executed if they *are* executable (which, on Unix systems, requires `chmod u+x`).

Both scripts get passed the following arguments:

1. The build prefix
2. The string `{pre,post}-build` (to allow for singular scripts doing both kinds of actions).

## Maintainer

- Andrew Zyabin - @schas002 - founder, Software section maintainer

## License

[MIT](LICENSE) &copy; CybreDisk contributors
