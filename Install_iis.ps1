$CurrentDate = (Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')
$logpath="c:\Windows\Temp"
Start-Transcript $logpath\IIS-Install-$CurrentDate.txt
$namelist="Web-Server
Web-WebServer
Web-Common-Http
Web-Default-Doc
Web-Dir-Browsing
Web-Http-Errors
Web-Static-Content
Web-Health
Web-Http-Logging
Web-Performance
Web-Stat-Compression
Web-Security
Web-Windows-Auth
Web-Filtering
Web-App-Dev
Web-Net-Ext45
Web-Asp-Net45
Web-ISAPI-Ext
Web-ISAPI-Filter
Web-Mgmt-Tools
Web-Mgmt-Console"

$names=$namelist.split([Environment]::NewLine,[System.StringSplitOptions]::RemoveEmptyEntries)
foreach ($name in $names)
{

Install-WindowsFeature $name

}
Stop-Transcript 
 
