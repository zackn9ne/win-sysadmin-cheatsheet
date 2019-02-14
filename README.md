# win-sysadmin-cheatsheet

*** Restore default power settings (cmd)

`powercfg -restoredefaultschemes`

*** update office via click2run.exe (ps1)

```
$Command = "C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe"

& $Command /update user updatepromptuser=true forceappshutdown=true displaylevel=true
```

*** install dbeaver (ps1) latest ver
```
$src = "https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe"
$dest = "C:\temp\dbeaver-ce-5.3.4-x86_64-setup.exe" 


Function DownloadInstaller(){
Invoke-WebRequest -src $src -DestFile $dest
$msifile = Get-ChildItem -Path $dest -File -Filter '*.ms*' 
write-host " MSI $dest was downloaded "
}
Start-Job -Name WebReq -ScriptBlock {
    DownloadInstaller }

Function InstallApp{
$process = Start-Process -FilePath "$dest" -ArgumentList "-s"
}
```
