# Adb Auto Screenshot Scripts

This repository contains scripts to automate the process of taking screenshots on Android devices using ADB (Android Debug Bridge). The scripts support features like auto-scrolling to capture individual screenshots of long pages.

## Usage

Run the autoscroller and autoscreenshotter scripts:

```powershell
.\screenshot.ps1
```

Capture single screenshot:

```powershell
adb shell "screencap -p /storage/emulated/0/screen.png"
adb pull "/storage/emulated/0/screen.png" "screen.png"
```

## Demo

See this video https://youtu.be/cPjPI_leg8g
