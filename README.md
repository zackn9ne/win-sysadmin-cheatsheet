# win-sysadmin-cheatsheet

*** Mount USB drive in WSL

`sudo mount -t drvfs D: /mnt/d`

*** Update Windows by command line

```
1. Download this tool: WSUS Offline Update: http://download.wsusoffline.net/
2. Create the installer for the target machine using: wsusoffline\UpdateGenerater.exe
3. On the client run: wsusoffline\client\UpdateInstaller.exe (deselect things about C++) and let it run on the client
```

*** Force 1809 update (microsoft way/same page as create install media)

`download the update assistant: https://www.microsoft.com/en-us/software-download/windows10`

*** Restore default power settings (cmd)

`powercfg -restoredefaultschemes`

*** Keep computer alive

`powercfg /change monitor-timeout-ac 5000`

*** Refresh group policy

`gpupdate -force`

*** For fun get external IP (ps1)
`(Invoke-WebRequest -uri "https://api.ipify.org/").Content`

*** shutdowns and restarts
```
shutdown /r /t 0
shutdown /s /f /t 1
```


# install office365 (Microsoft way Office Deployment Tool)

```
bing for Office Deployment Tool
cd to that directory
setup /configure configuration-Office365-x64.xml
```

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
Invoke-WebRequest $link -OutFile $outfile

Start-Job -Name WebReq -ScriptBlock {
    DownloadInstaller }

Function InstallApp{
$process = Start-Process -FilePath "$outfile" -ArgumentList "/S /allusers"
}
```

*** install chrome (ps1 as user non admin ok)
```
download:
https://cloud.google.com/chrome-enterprise/browser/download/#


>msiexec.exe /i "C:\temp\GoogleChromeStandaloneEnterprise64.msi" /qb-!
```

*** install slack (ps1 non admin ok as user) (lately only will run as admin)
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

*** install dropbox (ps admin console can't hurt)
```
$outfile = ".\Dropbox 66.4.84 Offline Installer.exe"
Function InstallApp{
    $process = Start-Process -FilePath "$outfile" -ArgumentList "/S"
}
InstallApp
```

*** install lenovo (ps1 admin)
```
$link = "https://download.lenovo.com/pccbbs/thinkvantage_en/systemupdate5.07.0074.exe"
$outfile = "C:\temp\len.exe" 


Function DownloadInstaller(){
Invoke-WebRequest $link -OutFile $outfile
}
DownloadInstaller
Function InstallApp{
$process = Start-Process -FilePath "$outfile" -ArgumentList "/Silent"
}
InstallApp
```

*** windows 10 meraki vpn (ps1 administrative prompt)

```
# remembercredential will save the first good username/pw credential entered in GUI
# put shared key for "insert VPN password"
# dnssuffix is like ad.companyname.com but probably dosent matter
# type over the brackets with the values and put in quotes only

Add-VpnConnection -AllUserConnection -Name "[insert VPN name]" -ServerAddress [insert IP/hostname for VPN] -TunnelType L2tp -DNSSuffix "[insert domain name]" -EncryptionLevel Optional -AuthenticationMethod PAP -L2tpPsk "[insert VPN password]" -Force -PassThru -RememberCredential

```
