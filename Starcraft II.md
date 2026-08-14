**Tested AP World Version**: 4.0.0  
**Tested Linux Flavors**: Arch (CachyOS)

# Prerequisites
* [Steam](https://store.steampowered.com/about/)
* The Linux release of Archipelago
    * These instructions are for the tar.gz release, not for the AppImage release
* The Windows release of the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk)
* [ProtonTricks](https://github.com/matoking/protontricks)
* [DXVK](https://github.com/doitsujin/dxvk/releases/latest) (Optional)

# Installation Steps

### Installing Starcraft II
1. Download the official Windows version of the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk).
2. Open Steam, click `Add a Game` on the bottom left, select `Add a Non-Steam Game` and select the Battle.net installer.
3. Right-click on the entry in your library and select `Properties...`.
4. In the `Compatibility` tab, check `Force the use of a specific Steam Play compatibility tool` and select `Proton Experimental` from the dropdown.
5. Close the window, select the entry, and click `Play`.
6. Follow the steps to install the launcher. I suggest changing the default install location to make it easier to find later.
7. Once the installation completes the login prompt will appear. Close this window as we do not want to log in yet.
8. Remove the installer from Steam by right-clicking the entry and selecting `Manage > Remove non-Steam game from your library`.
9. As we did for the installer, add a non-Steam game, this time selecting the `Battle.net Launcher.exe` executable that was created by the installer.
10. As we did for the installer, change the compatibility tool to `Proton Experimental`.
11. Click `Play` on the Battle.net Launcher entry.
    * It may crash the first time. Just relaunch it.
12. Log in using your Battle.net credentials.
    * Do **not** select the `Remember me` option - I have found this to cause the launcher to frequently crash. Your mileage may vary.
13. Install Starcraft 2 through the launcher. I suggest changing the default install location to make it easier to find later.
14. Close the Battle.net launcher.

### Installing performance patches (Optional, but recommended)
In most Wine versions Starcraft II is known to have stuttering. DXVK is a Vulkan-based translation layer of DirectX which can improve performance in certain titles, Starcraft II being one of them. Note that it is not advised to follow these steps if you plan to play Starcraft 2 multiplayer as editing DLLs in online multiplayer games is highly discouraged.

1. Open `ProtonTricks` and scroll down to the `Non-Steam shortcut: Battle.net Launcher` option. Make note of the number next to it as we will need it later.
2. Click the entry from the previous step and click `Ok`.
3. Select `Select the default wineprefix` and click `Ok`.
4. Select `Install a Windows DLL or component` and click `Ok`.
5. Select `d3dcompiler_42` and `d3dcompiler_47` and click `Ok`.
6. Close ProtonTricks.
7. Download the latest release of [DXVK](https://github.com/doitsujin/dxvk/releases/latest) and extract the archive.
8. Open your terminal in the extracted folder and execute the following commands to copy the DXVK DLLs into the prefix, replacing `APP_NUMBER` with the app number obtained in the previous section.

```bash
export WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/APP_NUMBER/pfx/"
cp x64/*.dll $WINEPREFIX/drive_c/windows/system32
cp x32/*.dll $WINEPREFIX/drive_c/windows/syswow64
winecfg
```

9. In the Wine configuration interface opened by the `winecfg` command above, select the `Libraries` tab.
10. In the `New override for library:` dropdown enter the following one by one, hitting the `Add` button after each one.
   * d3d8
   * d3d9
   * d3d10core
   * d3d11
   * dxgi
11. Hit the `Apply` button and close the window.

### Creating the script to initialize the environment
Certain variables need to be exported when running Starcraft II on Linux through Wine, otherwise the Archipelago Launcher will not be able to communicate with the game. This script prevents you from needing to reenter these exports every time you want to launch Starcraft II Archipelago.

1. Create a bash script somewhere called `Starcraft2.sh` and populate it with the following, making sure to replace the TODO segments:

```bash
#!/bin/bash

# Let the Archipelago client know we're running SC2 in Wine
export SC2PF=WineLinux
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Let the Archipelago client know where SC2 is installed
# TODO: Replace with path to StarCraft II install folder that contains the Starcraft II.exe executable
export SC2PATH="Path/To/StarCraft II/"

# Let the Archipelago client know what prefix SC2 is in so it can launch Wine with the correct configuration.
# TODO: Replace APP_NUMBER with the number Steam assigned the launcher.
export WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/APP_NUMBER/pfx/"

# DXVK variables. These are not necessary if you are not using DXVK.
# TODO: Replace with path to SC2 installation. (Same as SC2PATH)
export DXVK_STATE_CACHE_PATH="Path/To/StarCraft II/"
# Uncomment if you aren't using MangoHUD and want FPS info. See https://github.com/doitsujin/dxvk#hud for flags.
# export DXVK_HUD=fps

# Start the Archipelago client
# TODO: Replace the path to the launcher with the actual path on your system.
Path/To/ArchipelagoLauncher "Starcraft 2 Client"
```

2. Set the bash script to executable. `chmod +x Starcraft2.sh`
   
# Running the game
To start the game you should launch the Archipelago Launcher with the bash script above. The launcher may not work properly otherwise. After this point it works exactly the same way as it would on Windows.

You do not need Steam running in order to launch the game.

## Keeping the Starcraft 2 mod files updated
The first time you start the launcher you will need to download the Archipelago mod data. Run the command `/download_data` within the Starcraft 2 Archipelago launcher to download the latest mod data. This command can be rerun at any time to re-download the latest data. The launcher output itself will tell you when a new update is available.

If the mod data download stalls and you don't see the line `Download complete. Package installed.` after a handful of seconds you may need to change the file ownership of the StarCraft II directories to the current user.
