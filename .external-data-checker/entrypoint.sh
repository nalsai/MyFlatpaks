#!/bin/bash

if [[ -z "$GITHUB_WORKSPACE" || -z "$GITHUB_REPOSITORY" ]]; then
    echo "Script is not running in GitHub Actions CI"
    exit 1
fi

git config --global user.name "NalsaiBot" && \
git config --global user.email "bot@nalsai.de"

mkdir repos
cd repos

declare -A manifest
#manifest["https://github.com/Nalsai/AegisubFlatpak"]="org.wangqr.Aegisub.yml"
manifest["https://github.com/Nalsai/MothershipDefender2Flatpak"]="de.Nalsai.MothershipDefender2.yml"
#manifest["https://github.com/Nalsai/SpekFlatpak"]="cc.spek.Spek.yml"
manifest["https://github.com/DaRealRoyal/TacticalFlatpak"]="com.DaRealRoyal.TacticalMathReturns.yml"
manifest["https://github.com/Nalsai/gMKVExtractGUIFlatpak"]="net.sourceforge.gMKVExtractGUI.yml"
manifest["https://github.com/Nalsai/mkv-extractor-qt5-flatpak"]="com.github.mkv-extractor-qt5.yml"
#manifest["https://github.com/Nalsai/summarizer"]="de.haigruppe.summarizer.json"

for m in "${!manifest[@]}"; do
    git clone $m
    printf "==> checking %s in %s\n" "${manifest[$m]}" "$m"
    /app/flatpak-external-data-checker --update $(echo $m | sed 's:.*/::')/${manifest[$m]}
done
