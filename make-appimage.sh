#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q nxengine-evo-git | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export APPNAME="Cave Story NX-evo"
export ICON=/usr/share/icons/hicolor/256x256/apps/org.nxengine.nxengine_evo.png
export DESKTOP=/usr/share/applications/org.nxengine.nxengine_evo.desktop
export STARTUPWMCLASS=nxengine-evo
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/nxengine-evo

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the app normally quits before that time
# then skip this or check if some flag can be passed that makes it stay open
quick-sharun --simple-test ./dist/*.AppImage
