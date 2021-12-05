# My Flatpaks

📦 [Flatpak Docs](https://docs.flatpak.org/)

Don't forget to clone with `git clone --recursive` or run `git submodule update --init --recursive` if you forgot it.

## Installing

You can install my repo like this:

```bash
flatpak remote-add --if-not-exists NilsFlatpakRepo https://flatpak.nils.moe/NilsFlatpakRepo.flatpakrepo
```

Then you can install Flatpaks from there like this:

```bash
flatpak install NilsFlatpakRepo com.DaRealRoyal.TacticalMathReturns
```

Available Flatpaks are `org.wangqr.Aegisub`, `de.Nalsai.MothershipDefender2`, `cc.spek.Spek` and `com.DaRealRoyal.TacticalMathReturns`.

## Development

### Test a Flatpak

```bash
cd HelloFlatpak
flatpak-builder --force-clean build-dir org.flatpak.Hello.yml
flatpak-builder --user --install --force-clean build-dir org.flatpak.Hello.yml
flatpak run org.flatpak.Hello
```

### Make single file bundle

```bash
cd HelloFlatpak
flatpak-builder --repo=repo --force-clean build-dir org.flatpak.Hello.yml
flatpak build-bundle repo hello.flatpak org.flatpak.Hello stable --runtime-repo="https://flathub.org/repo/flathub.flatpakrepo"
```

### Make Repo

#### Build

```bash
flatpak-builder --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/Aegisub AegisubFlatpak/org.wangqr.Aegisub.yml
flatpak-builder --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/MD2 MothershipDefender2Flatpak/de.Nalsai.MothershipDefender2.yml
flatpak-builder --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/MD2 SpekFlatpak/cc.spek.Spek.yml
flatpak-builder --gpg-sign=7E56B236E04AD5F0 --repo=_/repo --force-clean _/build/TMR TacticalFlatpak/com.DaRealRoyal.TacticalMathReturns.yml
```

#### Upload

```bash
rclone sync _/repo NilsVPS:/var/www/flatpak.nils.moe/repo --progress
```

### Update submodules

```bash
git submodule update --remote --merge --recursive
```

