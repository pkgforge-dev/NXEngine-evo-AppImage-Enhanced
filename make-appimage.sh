#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=./nxengine-evo/platform/xdg/org.nxengine.nxengine_evo.png
export DESKTOP=./nxengine-evo/platform/xdg/org.nxengine.nxengine_evo.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/nxengine-evo
#quick-sharun /usr/bin/nxengine-evo
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ./AppDir/.env

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
