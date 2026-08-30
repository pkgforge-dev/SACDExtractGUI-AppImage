#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=0.1
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"

# Deploy dependencies
quick-sharun ./AppDir/bin/* \
    /usr/lib/jvm/java*

# Turn AppDir into AppImage
quick-sharun --make-appimage
