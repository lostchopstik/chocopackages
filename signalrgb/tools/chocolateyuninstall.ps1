$ErrorActionPreference = 'Stop'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'signalrgb'
  fileType      = 'EXE'
  silentArgs   = '--silent'
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    # Break apart the uninstall string
    $uninstallStringArr = $($_.UninstallString).split(' ')

    # Set the file path
    $packageArgs['file'] = $uninstallStringArr[0]

    # Set the silent arguments and append the uninstall args
    $packageArgs['silentArgs'] = "$($packageArgs['silentArgs']) $($uninstallStringArr[1..($uninstallStringArr.length-1)] -join ' ')"

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}