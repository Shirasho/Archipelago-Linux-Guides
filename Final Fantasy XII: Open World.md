**Game Version**: Steam  
**Tested AP World Version**: 0.6.3  
**Tested Linux Flavors**: Arch (CachyOS)

# Prerequisites
* The [Final Fantasy XII Open World Archipelago](https://github.com/Bartz24/Archipelago/releases/latest) release files for the latest version (download the FF12Randomizer 7z file and the apworld file)
* [Protonhax](https://github.com/jcnils/protonhax)
* Basic knowledge of Wine/Steam prefixes + compatdata

# Installation Steps
1. Install Final Fantasy XII: Zodiac Age on Steam.
2. In the Compatibility tab change the compatibility tool to `Proton Experimental` or `Proton 9`.
3. Run the game once to generate the wine prefix.
4. Install `protonhax` if it is not already installed (you can follow the installation instructions in the repo).
5. Open the Properties of the game and enter `protonhax init %command%` into the launch options.
6. Install .NET 8 desktop into the prefix using the following command, ensuring you have updated the Wine prefix path to the correct path: `WINEPREFIX="PATH/TO/steamapps/compatdata/595520/pfx" winetricks dotnetdesktop8`
7. Download the latest **Windows** installer for [Archipelago](https://github.com/ArchipelagoMW/Archipelago/releases/latest).
8. Install the Archipelago installer into the game prefix by running `WINEPREFIX="PATH/TO/steamapps/compatdata/595520/pfx" wine ./Setup.Archipelago.#.#.#.exe`, replacing `#` with the correct version number.
9. The previous step will install Archipelago to `"PATH/TO/steamapps/compatdata/595520/pfx/drive_c/ProgramData/Archipelago`. Open that directory and copy the apworld from the FFXII Archipelago release into the `custom_worlds` directory.
10. Extract the `FF12Randomizer#.#.#.#.7z` file from the AP release and move the extracted directory to somewhere persistent.
11. The extraction in the previous step will provide you with a file called `FF12Rando.exe`. Add that game to Steam as a non-Steam game.
12. Open the Properties of the newly added FF12Rando executable and enter `STEAM_COMPAT_DATA_PATH="PATH/TO/steamapps/compatdata/595520" %command%` into the launch options, ensuring you have updated the Wine prefix path to the correct path.
13. In the Compatibility tab change the compatibility tool to `Proton Experimental` or `Proton 9`.

At this point you can generate a seed and play the game.

# Rando Generation Steps
1. Launch `FF12Rando.exe` through Steam.
2. Follow the instructions on the Archipelago release page linked above for generating the seed (at the time of writing it is under the **Randomizer Seed Setup After Room is Opened** section of the release notes).
3. Run Final Fantasy XII: The Zodiac Age through Steam.
4. Once the game has launched and has gotten to the main menu run the following command: `protonhax run 595520 "PATH/TO/steamapps/compatdata/595520/pfx/drive_c/ProgramData/Archipelago/ArchipelagoLauncher.exe" "FF12 Open World Client"`, ensuring you have updated the Wine prefix path to the correct path.

It may be easier to write a bash script that can launch the game for you. I use something similar to the following:

```bash
#!/usr/bin/env bash

# --- Launch the game with Steam ---
steam -applaunch 595520 &

if ! pidof "FFXII_TZA.exe" > /dev/null
then
    echo 'Waiting for FFXII process to launch'
    sleep 1s
fi

# Wait just a little bit for the thing to bootstrap.
echo 'Waiting for FFXII process to bootstrap'
sleep 5s

# --- Launch the AP client through protonhax ---
echo 'Launching AP launcher via protonhax'
protonhax run 595520 $AP_LAUNCHER_PATH "FF12 Open World Client"
```
