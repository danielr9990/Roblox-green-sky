# Locate the current Roblox version folder
$localAppData = [System.Environment]::GetFolderPath('LocalApplicationData')
$robloxVersions = Get-ChildItem -Path "$localAppData\Roblox\Versions"

foreach ($version in $robloxVersions) {
    $skyPath = "$($version.FullName)\PlatformContent\pc\textures\sky"
    
    if (Test-Path $skyPath) {
        Write-Host "Found Roblox Sky folder: $skyPath"
        
        # Replace 'YOUR_USERNAME' and 'YOUR_REPO' with your GitHub details
        $githubUrl = "https://raw.githubusercontent.com"
        $faces = @("skyrenderbk", "skyrenderdn", "skyrenderft", "skyrenderlf", "skyrenderrt", "skyrenderup")
        
        foreach ($face in $faces) {
            $file = "$face.tex"
            Write-Host "Downloading $file..."
            Invoke-WebRequest -Uri "$githubUrl/$file" -OutFile "$skyPath\$file"
        }
        Write-Host "Green sky applied successfully!"
    }
}
