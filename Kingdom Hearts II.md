**Game Version**: Steam  
**Tested AP World Version**: 2.0.0  
**Tested Linux Flavors**: Arch (CachyOS)

_This guide should be similar for Kingdom Hearts I, but there is different randomizer software used._

# Prerequisites
* [OpenKH Mod Manager](https://github.com/OpenKH/OpenKh/releases/latest/)
* Basic knowledge of Wine/Steam prefixes + compatdata

# Installation Steps
1. Install Kingdom Hearts 1.5+2.5 ReMIX on Steam.
2. In the Compatibility tab change the compatibility tool to `Proton Experimental`.
3. Open the Properties of the game and enter `SteamDeck=1 WINEDLLOVERRIDES="version=n,b" STEAM_COMPAT_LAUNCHER_SERVICE=proton %command%` into the launch options.
    * `SteamDeck=1` fixes a known issue on Linux where cutscenes do not play correctly.
        * This is required regardless of whether you are running a randomizer or not. It is needed for the base game to work.
    * `WINEDLLOVERRIDES="version=n,b"` is needed to allow the mod loader to properly load the mods.
        * This is not necessary if you are using the bash script referenced below to start the game.
    * `STEAM_COMPAT_LAUNCHER_SERVICE=proton` tells the Steam Runtime to keep a communication channel active for the Proton container. This lets you run companion tools inside an already running Windows game session.
        * This is not necessary if you are using the bash script referenced below to start the game.
4. Run the game once to generate the wine prefix.
5. Install .NET 8 desktop into the prefix using the following command, ensuring you have updated the Wine prefix path to the correct path: `WINEPREFIX="PATH/TO/steamapps/compatdata/2552430/pfx" winetricks dotnetdesktop8`
6. Download the latest **Windows** installer for [Archipelago](https://github.com/ArchipelagoMW/Archipelago/releases/latest).
7. Install the Archipelago installer into the game prefix by running `WINEPREFIX="PATH/TO/steamapps/compatdata/2552430/pfx" wine ./Setup.Archipelago.#.#.#.exe`, replacing `#` with the correct version number.
8. Extract the latest OpenKH Mod Manager into the `ProgramData` directory of the Kingdom Hearts 2 Wine prefix: `PATH/TO/steamapps/compatdata/2552430/pfx/drive_c/ProgramData/OpenKH`.
9. Add OpenKH as a non-Steam game to Steam. If extracted to the location in the previous step it would be located at `PATH/TO/steamapps/compatdata/2552430/pfx/drive_c/ProgramData/OpenKH/OpenKh.Tools.ModsManager.exe`.
10. Open the properties of the application. In the Compatibility tab change the compatibility tool to `Proton Experimental`.
11. In the Shortcut tab enter `STEAM_COMPAT_DATA_PATH="PATH/TO/steamapps/compatdata/2552430" %command%` into the launch options.
12. Run OpenKH in Steam and follow the [instructions](https://tommadness.github.io/KH2Randomizer/setup/Panacea-ModLoader/) for configuring the mod loader.
    * You may need to manually set the path to your Kingdom Hearts II installation if it is not installed in the default location.
13. Install the mods listed in the [required software](https://archipelago.gg/tutorial/Kingdom%20Hearts%202/setup_en#required-software) section of the Kingdom Hearts II Archipelago page.

# Rando Generation Steps
1. Download the Kingdom Hearts 2 patch file from your Archipelago event host (or grab the one you generated locally).
2. Launch OpenKH through Steam.
3. Install the mod through OpenKH, ensuring it is at the very top of the mod list.
4. Select `Mod Loader > Build Only` from the dropdown menu at the top. After building is complete you can close OpenKH.

# Running the game
There are two different approaches to running the game - using a bash script or using [Protonhax](https://github.com/jcnils/protonhax). The recommended approach is to use a modified version of the included [Kingdom Hearts 2 bash script](./scripts/KingdomHearts.sh).

## Bash
1. Download the bash script included above.
2. Modify the variables at the top of the file to match your installation setup.
3. Set the script to be executable.
4. Run the script to start both the game and the Kingdom Hearts II Archipelago client.

## Protonhax
_Protonhax is currently untested for this game._

You can theoretically use Protonhax by running the commands below:

```bash
steam -applaunch 2552430

# Select Kingdom Hearts 2 within the in-game launcher and wait for it to get to the main menu for Kingdom Hearts 2

protonhax run 2552430 "PATH/TO/steamapps/compatdata/2552430/pfx/drive_c/ProgramData/Archipelago/ArchipelagoLauncher.exe" "KH2 Client"
```
