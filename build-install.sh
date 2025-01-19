#!/bin/bash
set -e
cd "$(dirname ${BASH_SOURCE[0]})"
git clone --depth 1 https://github.com/be5invis/Iosevka.git
cp $1 Iosevka/private-build-plans.toml
cd Iosevka
npm install
npm run build --verbose -- ttf::IosevkaCustom --jCmd=4
sudo bash -c "cp Iosevka/dist/IosevkaCustom/TTF/* /usr/local/share/fonts/ && fc-cache"
echo $(fc-match "Iosevka Custom")
