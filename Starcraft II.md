**Tested AP World Version**: 4.0.0  
**Tested Linux Flavors**: Arch (CachyOS)

# Prerequisites
* [Heroic Games Launcher](https://heroicgameslauncher.com/)
* The Linux release of Archipelago
    * These instructions are for the tar.gz release, not for the AppImage release
* [DXVK](https://github.com/doitsujin/dxvk/releases/latest)
* The Windows release of the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk)

# Installation Steps

## Installing Starcraft II
1. Download the official Windows version of the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk).
2. Install Heroic Games Launcher if it is not already installed.
3. Open Heroic Games Launcher, click `Add Game`, and name it `Starcraft II`.
4. Expand the `Show Wine settings` section and select either `ge-proton` or `wine-ge`.
5. Click on the `RUN INSTALLER FIRST` button and select the downloaded Battle.net installer.
    * If after selecting the installer the window closes without doing anything you may need to change the Wine version. For CachyOS I had to select `proton-cachyos-native`.
6. Follow the prompts to install the Battle.net launcher.
7. When installation is done, Battle.net will prompt you to log in. Do so with your Battle.net credentials.
8. Install StarCraft II directly through the Battle.net launcher. Once Starcraft II is installed you can close the Battle.net launcher.
9. Back in the Heroic Games Launcher, click on `Select Executable`. It will open up a file browser that defaults to the path in the `WinePrefix` section within Heroic Games Launcher for this game.
10. Navigate to the place you installed Starcraft II and select `StarCraft II.exe`.
11. Click `Finish` to add the game to Heroic Games Launcher.
12. Launch the game via Heroic Games Launcher to ensure the prefix has been created on disk. It will open up the installer again, but you can simply close the installer once it opens. At this point you can close Heroic Games Launcher.

## Installing performance patches (Optional, but recommended)
In most Wine versions Starcraft II is known to have stuttering. DXVK is a Vulkan-based translation layer of DirectX which can improve performance in certain titles, Starcraft II being one of them. Note that it is not advised to follow these steps if you plan to play Starcraft 2 multiplayer as editing DLLs in online multiplayer games is highly discouraged.

1. Download the latest release of [DXVK](https://github.com/doitsujin/dxvk/releases/latest) and extract the archive.
    * DXVK will fix most of the stuttering that is present in the game when using Wine and may improve FPS in some cases.
2. Open your terminal in the extracted folder and execute the following commands to copy the DXVK DLLs into the prefix, changing the `WINEPREFIX` path to be the Heroic Game Launcher path for the game.
    * If you let Heroic Games Launcher create the prefix for you, you can find the generated prefix by right-clicking on the game in the library and selecting `Details` - it will be the value defined in `WinePrefix folder:`.

```bash
export WINEPREFIX="PATH/TO/PREFIX"
cp x64/*.dll $WINEPREFIX/drive_c/windows/system32
cp x32/*.dll $WINEPREFIX/drive_c/windows/syswow64
winecfg
```

3. In the Wine configuration interface opened by the `winecfg` command above, select the `Libraries` tab.
4. In the `New override for library:` dropdown enter the following one by one, hitting the `Add` button after each one.
   * d3d8
   * d3d9
   * d3d10core
   * d3d11
   * dxgi
   * d3dcompiler_42
       * This library link can fix an issue with red-tinted textures caused by the same library provided by Wine
5. Hit the `Apply` button and close the window.

## Creating the script to initialize the environment
Certain variables need to be exported when running Starcraft II on Linux through Wine, otherwise the Archipelago Launcher will not be able to communicate with the game. This script prevents you from needing to reenter these exports every time you want to launch Starcraft II Archipelago.

1. Create a bash script somewhere called `Starcraft2.sh` and populate it with the following:

```bash
#!/bin/bash

# Let the Archipelago client know we're running SC2 in Wine
export SC2PF=WineLinux
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Let the Archipelago client know where SC2 is installed
# TODO: Replace with path to StarCraft II install folder
export SC2PATH="Path/To/StarCraft II/"

# Let the Archipelago client know what prefix SC2 is in so it can launch Wine with the correct configuration.
export WINEPREFIX="PATH/TO/PREFIX"

# DXVK variables. These are not necessary if you are not using DXVK.
# TODO: Replace with path to Battle.net prefix created by the Heroic Games Launcher. The default location is "$HOME/Games/Heroic/Prefixes/default/StarCraft II"
export DXVK_STATE_CACHE_PATH="PATH/TO/PREFIX"
export WINEDLLOVERRIDES="d3d8;d3d9;d3d10core;d3d11;dxgi;d3dcompiler_42"
# Uncomment if you aren't using MangoHUD and want FPS info. See https://github.com/doitsujin/dxvk#hud for flags.
# export DXVK_HUD=fps

# Start the Archipelago client
# TODO: Replace the path to the launcher with the actual path on your system.
Path/To/ArchipelagoLauncher "Starcraft 2 Client"
```

2. Set the bash script to executable. `chmod +x Starcraft2.sh`
   
# Running the game
To start the game you should launch the Archipelago Launcher with the bash script above. The launcher may not work properly otherwise. After this point it works exactly the same way as it would on Windows.

You do not need Heroic Games Launcher running in order to launch the game.

## Keeping the Starcraft 2 mod files updated
The first time you start the launcher you will need to download the Archipelago mod data. Run the command `/download_data` within the Starcraft 2 Archipelago launcher to download the latest mod data. This command can be rerun at any time to re-download the latest data. The launcher output itself will tell you when a new update is available.

If the mod data download stalls and you don't see the line `Download complete. Package installed.` after a handful of seconds you may need to change the file ownership of the StarCraft II directories to the current user.
