# My Flatpaks

📦 [Flatpak Docs](https://docs.flatpak.org/)

Run `git submodule update --init --remote --merge --recursive` after cloning to clone the submodules and update them.

## Installing

You can install my repo like this:

```bash
flatpak remote-add --if-not-exists nalsai https://flatpak.nils.moe/repo/nalsai.flatpakrepo
```

Then you can install Flatpaks from there like this:

```bash
flatpak install nalsai de.Nalsai.MothershipDefender2
```

Available Flatpaks are:

- `de.haigruppe.summarizer`
- `de.Nalsai.MothershipDefender2`
- `com.DaRealRoyal.TacticalMathReturns`
- `com.github.mkv-extractor-qt5`
- `net.sourceforge.gMKVExtractGUI`

`org.wangqr.Aegisub` and `cc.spek.Spek` are also available, but they are no longer maintained as they are on flathub (as `org.aegisub.Aegisub` and `cc.spek.Spek`). You can install them from there if you want.

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
