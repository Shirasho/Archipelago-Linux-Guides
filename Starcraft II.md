**Tested AP World Version**: 4.0.0  
**Tested Linux Flavors**: Arch (CachyOS)

# Prerequisites
* [Heroic Games Launcher](https://heroicgameslauncher.com/)
* The Linux release of Archipelago
    * These instructions are for the tar.gz release, not for the AppImage release
* [DXVK](https://github.com/doitsujin/dxvk/releases/latest)
* The Windows release of the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk)

# Installation Steps
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
13. Download the latest release of [DXVK](https://github.com/doitsujin/dxvk/releases/latest) and follow the [installation instructions](https://github.com/doitsujin/dxvk#how-to-use).
    * DXVK will fix most of the stuttering that is present in the game when using Wine and may improve FPS in some cases.
    * If you let Heroic Games Launcher create the prefix for you, you can find the generated prefix by right-clicking on the game in the library and selecting `Details`; it will be the value defined in `WinePrefix folder:`.
14. Create a bash script somewhere called `Starcraft2.sh` and populate it with the following:

```bash
#!/bin/bash

# Let the client know we're running SC2 in Wine
export SC2PF=WineLinux
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Replace with path to StarCraft II install folder
export SC2PATH="Path/To/StarCraft II/"

# Replace with path to Battle.net prefix created by the Heroic Games Launcher.
# The default location is "$HOME/Games/Heroic/Prefixes/default/StarCraft II"
export WINEPREFIX="PATH/TO/PREFIX"
export DXVK_STATE_CACHE_PATH="PATH/TO/PREFIX"
export WINEDLLOVERRIDES="d3d8;d3d9;d3d10core;d3d11;dxgi"

# Uncomment if you aren't using MangoHUD and want FPS info. See https://github.com/doitsujin/dxvk#hud for flags.
# export DXVK_HUD=fps

# Start the Archipelago client
Path/To/ArchipelagoLauncher "Starcraft 2 Client"
```

15. Set the bash script to executable and run the script. The Starcraft2 Archipelago client should launch. 
16. Within the Starcraft2 Archipelago client run the command `/download_data`.
    * If this download stalls and you don't see the line `Download complete. Package installed.` you may need to change the file ownership of the StarCraft II directories to the current user.
   
# Game Instructions
To start the game you must launch the Archipelago Launcher with the bash script above. The launcher will not work properly otherwise. After this point it works exactly the same way as it would on Windows.

You do not need Heroic Games Launcher running in order to launch the game.
