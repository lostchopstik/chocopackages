
$ErrorActionPreference = 'Stop'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://release.signalrgb.com/Install_SignalRgb.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  softwareName  = 'signalrgb'
  silentArgs    = '--silent'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs

















