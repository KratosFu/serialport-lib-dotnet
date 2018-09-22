$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
#$version = [System.Reflection.Assembly]::LoadFile("$root\SerialPortLib\bin\Debug\SerialPortLib.dll").GetName().Version

$versionStr = "{0}" -f ($env:APPVEYOR_REPO_TAG_NAME)

if (-not ([string]::IsNullOrEmpty($versionStr))) {
  Write-Host "Setting .nuspec version tag to $versionStr"

  $content = (Get-Content $root\SerialPortLib\SerialPortLib.nuspec) 
  $content = $content -replace '\$version\$',$versionStr

  $content | Out-File $root\SerialPortLib\SerialPortLib.compiled.nuspec

  & nuget pack $root\SerialPortLib\SerialPortLib.compiled.nuspec
}

