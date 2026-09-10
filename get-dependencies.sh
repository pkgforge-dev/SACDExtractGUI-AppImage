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
mkdir -p ./AppDir/bin
wget -P ./AppDir/bin https://github.com/rpmzine/SACDExtractGUI/raw/refs/heads/master/SACDExtractGUI.jar 
git clone --depth 1 https://github.com/EuFlo/sacd-ripper
cd sacd-ripper/tools/sacd_extract
cmake -DCMAKE_BUILD_TYPE=Release .
make -j$(nproc)
mv -v sacd_extract ../../../AppDir/bin
