$sourceDir=$args[0]
$targetDir=$args[1]

if (! (Test-Path -Path $targetDir -PathType Container)) {
    Write-Host "The $targetDir is not a directory"
    Return
}

if (Test-Path -Path $sourceDir -PathType Container) {
    $files=$(Get-ChildItem -Recurse $sourceDir | Where-Object { ! $_.PSIsContainer})

    foreach ($file in $files) {
        Write-Host $file.FullName
        Write-Host $file.Name
        $creationTime=$file.creationTime
        Write-Host $creationTime
        $year=$creationTime.Year
        $month=$creationTime.Month
        Write-Host "$year, $month"
        $finalTargetDir = Join-Path -Path $targetDir -ChildPath "$year" | Join-Path -ChildPath "m$month" 
        if (!(Test-Path -Path $finalTargetDir)) {
            New-Item $finalTargetDir -ItemType Directory
        }
        Write-Host $finalTargetDir
        Copy-Item $file.FullName -Destination $finalTargetDir -PassThru -Force
    }
}
else {
    Write-Host "$sourceDir is not a directory"
}
