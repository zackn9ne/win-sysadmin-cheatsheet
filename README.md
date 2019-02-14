# win-sysadmin-cheatsheet

*** Restore default power settings (cmd)

`powercfg -restoredefaultschemes`

*** update office via click2run.exe (ps1)

```
$Command = "C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe"

$Command /update user updatepromptuser=true forceappshutdown=true displaylevel=true
```

*** install dbeaver (ps1 non-admin ok as user) latest ver
```
$link = "https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe"
$outfile = "C:\temp\dbeaver-ce-5.3.4-x86_64-setup.exe" 

Invoke-WebRequest $link -OutFile $file


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

*** install slack (ps1 non admin ok as user)
```
$soft_name = "slack"
$link = "http://slack.com/ssb/download-win64-msi"
$file = "c:\Temp\slack.msi"

Invoke-WebRequest $link -OutFile $file


Function Install_MSI_slack_Installer{
$arguments= ' /qn /l*v .\install_slack.txt' 
Start-Process `
     -file  $file `
     -arg $arguments `
     -passthru | wait-process
}

Install_MSI_slack_Installer 
```
