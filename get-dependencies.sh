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

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
wget https://github.com/setmind/SACDExtractGUI/releases/download/v0.1/SACDExtractGUI.zip
#wget https://github.com/EuFlo/sacd-ripper/releases/download/0.3.9.3b/sacd_extract-0.3.9.3-173-linux.zip
git clone https://github.com/EuFlo/sacd-ripper

mkdir -p ./AppDir/bin
bsdtar -xvf SACDExtractGUI.zip -C ./AppDir/bin
chmod +x ./AppDir/bin/SACDExtractGUI.jar
#bsdtar -xvf sacd_extract-0.3.9.3-173-linux.zip -C ./AppDir/bin
rm -f *.zip ./AppDir/bin/LICENSE ./AppDir/bin/README.md
cd sacd-ripper/tools/sacd_extract
cmake -DCMAKE_BUILD_TYPE=Release .
#cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_C_FLAGS="-fcommon -Wno-int-conversion -Wno-incompatible-pointer-types -Wno-implicit-function-declaration" .
make -j$(nproc)
mv -v sacd_extract ../../../AppDir/bin
