# My Flatpaks

📦 [Flatpak Docs](https://docs.flatpak.org/)

Run `git submodule update --init --remote --merge --recursive` after cloning to clone the submodules and update them.

## Installing

You can install my repo like this:

```bash
flatpak remote-add --if-not-exists NilsFlatpakRepo https://flatpak.nils.moe/NilsFlatpakRepo.flatpakrepo
```

Then you can install Flatpaks from there like this:

```bash
flatpak install NilsFlatpakRepo com.DaRealRoyal.TacticalMathReturns
```

Available Flatpaks are `org.wangqr.Aegisub`, `de.haigruppe.summarizer`, `de.Nalsai.MothershipDefender2`, `cc.spek.Spek`, `com.DaRealRoyal.TacticalMathReturns`, `com.github.mkv-extractor-qt5`, `gg.minion.Minion` and `net.sourceforge.gMKVExtractGUI`.

## Development

### Test a Flatpak

```bash
cd HelloFlatpak
flatpak-builder --install-deps-from=flathub --force-clean build-dir org.flatpak.Hello.yml
flatpak-builder --user --install --force-clean build-dir org.flatpak.Hello.yml
flatpak run org.flatpak.Hello
```

### Make single file bundle

```bash
cd HelloFlatpak
flatpak-builder --install-deps-from=flathub --force-clean --repo=repo build-dir org.flatpak.Hello.yml
flatpak build-bundle repo hello.flatpak org.flatpak.Hello stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
```
