# win-sysadmin-cheatsheet

** UPN 
* this changes the UPN on the o365
```
12:49 PM Umit: $msolcred = get-credential
12:49 PM Umit: connect-msolservice -credential $msolcred
12:50 PM Umit: Set-MsolUserPrincipalName -UserPrincipalName user@contoso.onmicrosoft.com -NewUserPrincipalName newuser@contoso.com
```
* verify the UPN by finding the user in AD, selecting Attribute Editor, and scrolling to UserPrincipalName locally

** Is Workstation Azure ad joined?
` dsregcmd /status `

** Is user domain joined or not?
```
> whoami
> echo %logonserver% 
 using a local account then you will get as a result Computer\username
If you are logged using a domain account then you will get as a result Domain\username 
```

** Server Core
`sconfig`
` Install-WindowsFeature File-Services`

# intune
** Enroll in intune
```
Install-Script -Name Get-WindowsAutoPilotInfo
Set-ExecutionPolicy Bypass
D:\Get-WindowsAutoPilotInfo.ps1 -OutPutFile d:\upload2intune.csv -append
```

** Get serialnumber
`gwmi win32_bios`

*** one liner silent installs

**** download filestream first, cmd this

`    GoogleDriveFSSetup --silent --desktop_shortcut`

*** Mount USB drive in WSL

`sudo mount -t drvfs D: /mnt/d`

*** Install WSL (admin powershell prompt) 1/2

`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`

*** install ubuntu for WSL (powershell) 2/2

`Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1604 -OutFile Ubuntu.appx -UseBasicParsing`

*** Delete messed up drive maps
`net use z /delete`

*** Check drive maps
`net use`

*** Check AD bind (set command)
`systeminfo`

*** Remove from AD and put into WORKGROUP (elev ps1 prompt)
` Remove-Computer -UnjoinDomaincredential Domain01\Admin01 -PassThru -Verbose -Restart`

*** Update Windows by command line

```
1. Download this tool: WSUS Offline Update: http://download.wsusoffline.net/
2. Create the installer for the target machine using: wsusoffline\UpdateGenerater.exe
3. On the client run: wsusoffline\client\UpdateInstaller.exe (deselect things about C++) and let it run on the client
```

*** remove windows 10 Mail App, Lenovo, Preinstalled Office

```
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage 
Get-AppxPackage *Lenovo* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage 
```

*** Force 1809 update (microsoft way/same page as create install media)

`download the update assistant: https://www.microsoft.com/en-us/software-download/windows10`

*** Restore default power settings (cmd)

`powercfg -restoredefaultschemes`

*** Keep computer alive (for something like 83 hours)

`powercfg /change monitor-timeout-ac 5000`
`powercfg /change standby-timeout-ac 5000`



*** update AD Sync from Server to O365 ->

`Start-ADSyncSyncCycle -PolicyType Delta`

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
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$softname = "dbeaver"
$link = "https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe"
$file = "C:\Temp\dbeaver-ce-5.3.4-x86_64-setup.exe" 

Invoke-WebRequest $link -OutFile $file
# install manually
```

*** install chrome (ps1 as user non admin ok)
```
download:
https://cloud.google.com/chrome-enterprise/browser/download/#
2. unzip and cd into that folder


cmd>msiexec.exe /i "GoogleChromeStandaloneEnterprise64.msi" /qb-!
```


*** install dropbox (ps admin console can't hurt)
```
Download
https://www.dropbox.com/downloading?build=68.4.102&plat=win&type=full
# 2 liner
$outfile = "Dropbox 68.4.102 Offline Installer.exe"
$process = Start-Process -FilePath "$outfile" -ArgumentList "/S"
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

*** powershell update wallpaper function and example 
```
Function Set-WallPaper($Value)

{

 Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value

 rundll32.exe user32.dll, UpdatePerUserSystemParameters

}
Set-WallPaper -Value "C:\Temp\Company_Background.jpg"

```
