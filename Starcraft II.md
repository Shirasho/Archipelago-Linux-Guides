**Tested AP World Version**: 4.0.0  
**Tested Linux Flavors**: Arch (CachyOS)

# Prerequisites
* Heroic Games Launcher
* The Linux release of Archipelago
    * These instructions are for the tar.gz release, not for the AppImage release. 

# Installation Steps
1. Download the [Battle.net launcher](https://download.battle.net/en-us/?product=bnetdesk).
2. Open Heroic Games Launcher, click `Add Game`, and name it `Starcraft II`.
3. Expand the `Show Wine settings` section and select either `ge-proton` or `wine-ge`.
4. Click on the `RUN INSTALLER FIRST` button and select the downloaded Battle.net installer.
    * If after selecting the installer the window closes without doing anything you may need to change the Wine version. For CachyOS I had to select `proton-cachyos-native`.
5. Follow the prompts to install the Battle.net launcher.
6. When installation is done, Battle.net will prompt you to log in. Do so with your Battle.net credentials.
7. Install StarCraft II directly through the Battle.net launcher. Once Starcraft II is installed you can close the Battle.net launcher.
8. Back in the Heroic Games Launcher, click on `Select Executable`. It will open up a file browser that defaults to the path in the `WinePrefix` section within Heroic Games Launcher for this game.
9. Navigate to the place you installed Starcraft II and select `StarCraft II.exe`.
10. Click `Finish` to add the game to Heroic Games Launcher. At this point you can close Heroic Games Launcher.
11. Create a bash script somewhere called `Starcraft2.sh` and populate it with the following:

```bash
#!/bin/bash

# Let the client know we're running SC2 in Wine
export SC2PF=WineLinux
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Replace with path to StarCraft II install folder
export SC2PATH="Path/To/StarCraft II/"

# Start the Archipelago client
Path/To/ArchipelagoLauncher "Starcraft 2 Client"
```
12. Set the bash script to executable and run the script. The Starcraft2 Archipelago client should launch. 
13. Within the Starcraft2 Archipelago client run the command `/download_data`.
    * If this download stalls and you don't see the line `Download complete. Package installed.` you may need to change the file ownership of the StarCraft II directories to the current user.
   
# Game Instructions
To start the game you must launch the Archipelago Launcher with the bash script above. The launcher will not work properly otherwise. After this point it works exactly the same way as it would on Windows.

You do not need Heroic Games Launcher running in order to launch the game.
