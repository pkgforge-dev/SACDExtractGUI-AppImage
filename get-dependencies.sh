#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake       \
    jre-openjdk

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Getting app..."
echo "---------------------------------------------------------------"
wget https://github.com/setmind/SACDExtractGUI/releases/download/v0.1/SACDExtractGUI.zip
git clone https://github.com/EuFlo/sacd-ripper

mkdir -p ./AppDir/bin
bsdtar -xvf SACDExtractGUI.zip -C ./AppDir/bin
rm -f ./*.zip ./AppDir/bin/LICENSE ./AppDir/bin/README.md
cd sacd-ripper/tools/sacd_extract
cmake -DCMAKE_BUILD_TYPE=Release .
make -j$(nproc)
mv -v sacd_extract ../../../AppDir/bin
