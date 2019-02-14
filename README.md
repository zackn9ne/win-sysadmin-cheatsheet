# win-sysadmin-cheatsheet

*** Restore default power settings (cmd)

`powercfg -restoredefaultschemes`

*** update office via click2run.exe (ps1)

```
$Command = "C:\Program Files\Common Files\Microsoft Shared\ClickToRun\OfficeC2RClient.exe"

& $Command /update user updatepromptuser=true forceappshutdown=true displaylevel=true
```
