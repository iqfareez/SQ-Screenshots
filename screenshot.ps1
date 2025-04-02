# Set number of screenshots you want
$maxScreenshots = 150
$savePath = "$PSScriptRoot\screenshots"  # Saves screenshots in a folder

# Create folder if it doesn't exist
if (!(Test-Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath | Out-Null
}

# Initialize the screenshot counter
$screenshotCount = 1

# Function to take screenshots
function Take-Screenshots {
    param (
        [int]$startCount,
        [int]$numberOfScreenshots
    )
    
    $endCount = $startCount + $numberOfScreenshots - 1
    
    # Loop to take screenshots
    for ($i = $startCount; $i -le $endCount; $i++) {
        $devicePath = "/storage/emulated/0/screen.png"
        $localPath = "$savePath\page_$i.png"

        Write-Host "Taking screenshot $i..."
        
        # Capture screenshot and save on the device
        adb shell "screencap -p $devicePath"

        # Pull the screenshot from the device
        adb pull "$devicePath" "$localPath"

        # Remove screenshot from the device to free space
        adb shell "rm $devicePath"

        Write-Host "Screenshot $i saved as $localPath"

        # # Scroll down (Adjust swipe coordinates if needed)
        Write-Host "Scrolling down..."
        adb shell "input swipe 500 1500 500 500"

        # Scroll right
        # Write-Host "Scrolling right..."
        # adb shell "input swipe 100 1000 1000 1000"

        # Wait before taking the next screenshot
        Start-Sleep -Seconds 1
    }
    
    return $endCount
}

# Take initial batch of screenshots
$screenshotCount = Take-Screenshots -startCount $screenshotCount -numberOfScreenshots $maxScreenshots

Write-Host "✅ Screenshot process completed! Screenshots saved in $savePath"

# Prompt user to continue or exit
do {
    $response = Read-Host "Do you want to continue taking screenshots? (Y/N)"
    
    if ($response -eq "Y" -or $response -eq "y") {
        $screenshotCount = Take-Screenshots -startCount ($screenshotCount + 1) -numberOfScreenshots $maxScreenshots
        Write-Host "✅ Additional screenshots completed! Screenshots saved in $savePath"
    }
} while ($response -eq "Y" -or $response -eq "y")

Write-Host "Script execution completed."
