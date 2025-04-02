# Script to rename files by adjusting the number in the filename
# For example: page_141 -> page_140

# Define the directory where files are located
$directoryPath = "$PSScriptRoot\screenshots"

# Define the start and end of the range
$startNum = 604
$endNum = 605

# Loop through the specified range
for ($i = $startNum; $i -lt $endNum; $i++) {
    # Construct the original filename
    $oldFileName = "page_$i"
    
    # Construct the new filename (reduce by 1)
    $newFileName = "page_$($i-1)"
    
    # Check if file exists before renaming
    $oldFilePath = Join-Path -Path $directoryPath -ChildPath $oldFileName
    if (Test-Path -Path "$oldFilePath.*") {
        # Get the file with its extension
        $file = Get-Item "$oldFilePath.*"
        $extension = $file.Extension
        
        # Rename file
        $newFilePath = Join-Path -Path $directoryPath -ChildPath "$newFileName$extension"
        Rename-Item -Path $file.FullName -NewName $newFilePath -Force -ErrorAction SilentlyContinue
        
        Write-Host "Renamed: $($file.Name) -> $newFileName$extension"
    } else {
        Write-Host "File not found: $oldFileName.*"
    }
}

Write-Host "File renaming completed."