# Debian build environment in a docker container

Already setup, fast to use and update. Extend it with your own tools.

Layered on top of the [C build environment for docker](https://ownyourbits.com/2017/06/20/c-build-environment-in-a-docker-container/)

## Features

 - GCC 6
 - Debian package development tools: pbuilder, lintian, quilt, debuild, dh-make, fakeroot ...
 - quilt configured for debian patching
 - `ccache` for fast recompilation. Included in debuild and dpkg-buildpackage calls
 - `eatmydata` for faster compilation times

## Usage

### Compilation

Log into the development environment.

```
docker run --rm  -v "/workdir/path:/src" -ti ownyourbits/debiandev
```

Details at [ownyourbits](https://ownyourbits.com/)
