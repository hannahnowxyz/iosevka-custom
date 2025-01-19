#!/bin/bash
set -e
cd "$(dirname ${BASH_SOURCE[0]})"
mkdir Mathematica
cd Mathematica
curl https://reference.wolfram.com/language-assets/fonts/mathematica/Mathematica.woff > Mathematica.woff
curl https://reference.wolfram.com/language-assets/fonts/mathematica/Mathematica-Bold.woff > Mathematica-Bold.woff
python3 -m venv .venv
source .venv/bin/activate
pip install fonttools
pyftsubset Mathematica.woff --flavor="woff" --output-file="Mathematica-Subset.woff" --unicodes="U+E000-F8FF"
pyftsubset Mathematica-Bold.woff --flavor="woff" --output-file="Mathematica-Subset-Bold.woff" --unicodes="U+E000-F8FF"
#TODO a bit broken. fixes missing characters in Wolfram, but would like to "monospace-ify"
python3 -c "from fontTools.ttLib import TTFont;font = TTFont('Mathematica-Subset.woff');font.save('Mathematica-Subset.ttf');font = TTFont('Mathematica-Subset-Bold.woff');font.save('Mathematica-Subset-Bold.ttf')"
deactivate
sudo bash -c "cp *.ttf /usr/local/share/fonts/ && fc-cache"
echo $(fc-match "Mathematica")
