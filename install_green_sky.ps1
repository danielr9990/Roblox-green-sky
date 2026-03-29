# 1. Locate the current Roblox texture folder
$localAppData = [System.Environment]::GetFolderPath('LocalApplicationData')
$robloxVersions = Get-ChildItem -Path "$localAppData\Roblox\Versions"

foreach ($version in $robloxVersions) {
    $skyPath = "$($version.FullName)\PlatformContent\pc\textures\sky"
    
    if (Test-Path $skyPath) {
        Write-Host "Found Roblox Sky folder: $skyPath"
        
        # 2. Create a tiny 1x1 solid green PNG byte array
        # This represents a valid green image file
        $greenImageBytes = [System.Convert]::FromBase64String("iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M/wHwAEBgIA597ADwAAAABJRU5ErkJggg==")
        
        # 3. Names of the skybox faces Roblox uses
        $faces = @("skyrenderbk", "skyrenderdn", "skyrenderft", "skyrenderlf", "skyrenderrt", "skyrenderup")
        
        foreach ($face in $faces) {
            $filePath = Join-Path $skyPath "$face.tex"
            Write-Host "Creating and replacing $face.tex..."
            [System.IO.File]::WriteAllBytes($filePath, $greenImageBytes)
        }
        
        Write-Host "Green sky applied successfully for this version!"
    }
}

Write-Host "`nDone! Close and restart Roblox to see your green sky." -ForegroundColor Green
Pause
