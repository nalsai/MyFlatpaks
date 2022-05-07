#!/bin/bash

CheckSuccess()
{
  exit_code=$?
  if [ $exit_code -ne 0 ]; then 
    echo
    echo "An error occurred (〃＞＿＜;〃)"
    exit $exit_code
  fi
}

echo "Updating git submodules..."

git submodule update --init --remote --merge --recursive

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo
echo -n "Run flatpak-external-data-checker? [y/n]: "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
  echo y
  echo "installing flatpak-external-data-checker (error if already installed can be ignored)"
  flatpak install https://dl.flathub.org/repo/appstream/org.flathub.flatpak-external-data-checker.flatpakref
  flatpak run org.flathub.flatpak-external-data-checker AegisubFlatpak/org.wangqr.Aegisub.yml; echo
  flatpak run org.flathub.flatpak-external-data-checker gMKVExtractGUIFlatpak/net.sourceforge.gMKVExtractGUI.yml; echo
  flatpak run org.flathub.flatpak-external-data-checker mkv-extractor-qt5-flatpak/com.github.mkv-extractor-qt5.yml; echo
  #flatpak run org.flathub.flatpak-external-data-checker MothershipDefender2Flatpak/de.Nalsai.MothershipDefender2.yml; echo
  flatpak run org.flathub.flatpak-external-data-checker SpekFlatpak/cc.spek.Spek.yml; echo
  flatpak run org.flathub.flatpak-external-data-checker summarizer/de.haigruppe.summarizer.json; echo
  #flatpak run org.flathub.flatpak-external-data-checker TacticalFlatpak/com.DaRealRoyal.TacticalMathReturns.yml; echo
  read -rsp "Press enter to continue "
  echo
else
  echo n
fi

flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/Aegisub AegisubFlatpak/org.wangqr.Aegisub.yml
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/gMKVExtractGUI gMKVExtractGUIFlatpak/net.sourceforge.gMKVExtractGUI.yml
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/mkv-extractor-qt5 mkv-extractor-qt5-flatpak/com.github.mkv-extractor-qt5.yml
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/MD2 MothershipDefender2Flatpak/de.Nalsai.MothershipDefender2.yml
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/Spek SpekFlatpak/cc.spek.Spek.yml
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/summarizer summarizer/de.haigruppe.summarizer.json
CheckSuccess
flatpak-builder --install-deps-from=flathub --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/TMR TacticalFlatpak/com.DaRealRoyal.TacticalMathReturns.yml
CheckSuccess

echo
echo -n "Build single-file bundles? [y/n]: "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
  echo y
  flatpak build-bundle _/repo _/bundles/org.wangqr.Aegisub.flatpak org.wangqr.Aegisub stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/de.haigruppe.summarizer.flatpak de.haigruppe.summarizer stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/de.Nalsai.MothershipDefender2.flatpak de.Nalsai.MothershipDefender2 stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/cc.spek.Spek.flatpak cc.spek.Spek stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/com.DaRealRoyal.TacticalMathReturns.flatpak com.DaRealRoyal.TacticalMathReturns stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/com.github.mkv-extractor-qt5.flatpak com.github.mkv-extractor-qt5 stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
  flatpak build-bundle _/repo _/bundles/net.sourceforge.gMKVExtractGUI.flatpak net.sourceforge.gMKVExtractGUI stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
  CheckSuccess
else
  echo n
fi

flatpak build-update-repo _/repo --title=NilsFlatpakRepo \
  --comment="Repository of Flatpak applications made by Nils" --description="Repository of Flatpak applications made by Nils" \
  --homepage=https://flatpak.nils.moe/ --icon=https://flatpak.nils.moe/logo.png \
  --default-branch=stable --gpg-sign=7E56B236E04AD5F0 --generate-static-deltas --prune
CheckSuccess

echo
echo -n "Upload repo to server? [y/n]: "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
  echo y
  # https://github.com/ostreedev/ostree-releng-scripts/blob/master/rsync-repos
  # Use rsync to intelligently sync OSTree repositories. This
  # avoids a few race conditions and issues that could otherwise
  # occur if one simply does the whole repository in a single run.
  rsync -rlptvhe "ssh -p 2022" --include='/objects' --include='/objects/**' --include='/deltas' --include='/deltas/**' --exclude='*' --ignore-existing _/repo/ root@shiina.nils.moe:/root/docker/flatpak/site/repo/
  CheckSuccess
  rsync -rlptvhe "ssh -p 2022" --include='/refs' --include='/refs/**' --include='/summary*' --include='/summaries' --include='/summaries/**' --exclude='*' --delete _/repo/ root@shiina.nils.moe:/root/docker/flatpak/site/repo/
  CheckSuccess
  rsync -rlptvhe "ssh -p 2022" --include='/objects' --include='/objects/**' --include='/deltas' --include='/deltas/**' --exclude='*' --ignore-existing --delete _/repo/ root@shiina.nils.moe:/root/docker/flatpak/site/repo/
  CheckSuccess
  rsync -rlptvhe "ssh -p 2022" --include='/config' --exclude='*' --ignore-existing _/repo/ root@shiina.nils.moe:/root/docker/flatpak/site/repo/
  CheckSuccess
else
  echo n
fi

echo
echo "Done (づ˶•༝•˶)づ♡"