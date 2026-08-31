#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake      \
    sdl2_mixer \
    sdl2_ttf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini sdl2_image-mini

echo "Building NXEngine-evo..."
echo "---------------------------------------------------------------"
REPO="https://github.com/nxengine/nxengine-evo"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./NXEngine-evo
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./NXEngine-evo
wget https://www.cavestory.org/downloads/cavestoryen.zip
wget https://github.com/nxengine/translations/releases/download/v1.14/all.zip
bsdtar -xvf ./cavestoryen.zip
bsdtar -xvf ./all.zip
mkdir -p build && cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DPORTABLE=ON
make -j$(nproc)
cp -r "../CaveStory/data/" "./"
cp "../CaveStory/Doukutsu.exe" "./"
cp -r "../data/" "./"
./nxextract
mv -v nxengine-evo data ../../AppDir/bin
