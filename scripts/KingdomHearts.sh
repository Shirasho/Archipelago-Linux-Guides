#!/usr/bin/env bash

############################################################
# Auto-Detect Proton Launcher
############################################################

# USER REQUIRED CHANGES:
# Line 11: Change path to point to Kingdom Hearts remix installation directory.

# Set working directory.
cd "/PATH/TO/steamapps/common/KINGDOM HEARTS -HD 1.5+2.5 ReMIX-/"

# Set AppID
APPID=2552430

# --- Resolve absolute game directory ---
GAME_DIR="$(pwd)"

# --- Unset all Steam Environment being incorrectly applied to this script ---
unset LD_PRELOAD
unset SteamAppId
unset STEAM_RUNTIME
unset STEAM_COMPAT_CLIENT_INSTALL_PATH
unset STEAM_COMPAT_DATA_PATH

# --- Ensure steam_appid.txt exists next to script ---
echo "$APPID" > "$GAME_DIR/steam_appid.txt"

# --- Compute Steamapps directory relative to game folder ---
STEAMAPPS_DIR="$(realpath "$GAME_DIR/../..")"

# --- Proton prefix automatically based on compatdata ---
PREFIX="$STEAMAPPS_DIR/compatdata/$APPID"
COMPATDATA_DIR="$(dirname "$PREFIX")"

if [ ! -d "$PREFIX" ]; then
    zenity --error --text="Proton prefix not found at:\n$PREFIX"
    exit 1
fi

echo "[INFO] Using Proton prefix: $PREFIX"

# --- Find Proton binary via config_info (Fahrenheit method) ---
CONFIG_INFO="$PREFIX/config_info"

if [ ! -f "$CONFIG_INFO" ]; then
    zenity --error --text="config_info not found in prefix:\n$CONFIG_INFO"
    exit 1
fi

# Proton 'files' path is on line 2
PROTON_FILES_PATH=$(sed -n '2p' "$CONFIG_INFO")

# Go up 4 levels → locate 'proton'
PROTON_BIN="$(realpath "$PROTON_FILES_PATH/../../../proton")"

if [ ! -x "$PROTON_BIN" ]; then
    zenity --error --text="Proton binary not found:\n$PROTON_BIN"
    exit 1
fi

echo "[INFO] Using Proton binary: $PROTON_BIN"

# --- Executable list ---
declare -A GAMES
GAMES["KH1"]="$GAME_DIR/KINGDOM HEARTS FINAL MIX.exe"
GAMES["KH2"]="$GAME_DIR/KINGDOM HEARTS II FINAL MIX.exe"
GAMES["RECOM"]="$GAME_DIR/KINGDOM HEARTS Re_Chain Of Memories.exe"
GAMES["BBS"]="$GAME_DIR/KINGDOM HEARTS Birth by Sleep FINAL MIX.exe"

declare -A CLIENTS
CLIENTS["KH1"]="KH1 Client"
CLIENTS["KH2"]="KH2 Client"
CLIENTS["RECOM"]="KHRECOM Client"
CLIENTS["BBS"]="KHBBS Client"

# --- Select game ---
CHOICE=$(zenity --list --title="Select Kingdom Hearts Game" \
    --column="Game" "KH1" "KH2" "RECOM" "BBS" \
    --height=300 --width=400)

if [ -z "$CHOICE" ]; then
    exit 0
fi

EXE="${GAMES[$CHOICE]}"
CLIENT="${CLIENTS[$CHOICE]}"

if [ ! -f "$EXE" ]; then
    zenity --error --text="Game EXE not found:\n$EXE"
    exit 1
fi

# --- Archipelago launcher (stored inside prefix) ---
AP_LAUNCHER="$PREFIX/pfx/drive_c/ProgramData/Archipelago/ArchipelagoLauncher.exe"

if [ ! -f "$AP_LAUNCHER" ]; then
    zenity --error --text="Archipelago Launcher not found at:\n$AP_LAUNCHER"
    exit 1
fi

# --- Required environment ---
export WINEPREFIX="$PREFIX/pfx"
export STEAM_COMPAT_DATA_PATH="$COMPATDATA_DIR"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/root"
export WINEDLLOVERRIDES="version=n,b"
export SteamDeck="1"

# --- Launch Steam ---
if ! pidof steam > /dev/null
then
    steam &
    sleep 10s
fi

# --- Launch Archipelago (background) ---
"$PROTON_BIN" run "$AP_LAUNCHER" -- "$CLIENT" &

# --- Launch selected game ---
"$PROTON_BIN" run "$EXE"
