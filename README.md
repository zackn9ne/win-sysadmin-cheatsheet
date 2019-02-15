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


Function DownloadInstaller(){
Invoke-WebRequest -src $link -DestFile $outfile

Start-Job -Name WebReq -ScriptBlock {
    DownloadInstaller }

Function InstallApp{
$process = Start-Process -FilePath "$outfile" -ArgumentList "-s"
}
```

*** install chrome (ps1 as user non admin ok)
```
download:
https://cloud.google.com/chrome-enterprise/browser/download/#


>msiexec.exe /i "C:\Users\$user\Downloads\GoogleChromeEnterpriseBundle64\Installers\GoogleChromeStandaloneEnterprise64.msi" /qb-!
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
