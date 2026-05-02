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
    /usr/lib/jvm/java*/bin \
    /usr/lib/jvm/java*/conf \
    /usr/lib/jvm/java*/legal \
    /usr/lib/jvm/java*/lib

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
