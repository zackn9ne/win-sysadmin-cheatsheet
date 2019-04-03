$soft_name = "slack"
$link = "http://slack.com/ssb/download-win64-msi"
$file = "c:\windows\temp\slack.msi"

Invoke-WebRequest $link -OutFile $file


Function Install_MSI_slack_Installer{
$arguments= ' /qn /l*v .\install_slack.txt' 
Start-Process `
     -file  $file `
     -arg $arguments `
     -passthru | wait-process
}

Install_MSI_slack_Installer 
