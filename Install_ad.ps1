$CurrentDate = (Get-Date).ToString('MM-dd-yyyy_hh-mm-ss')
$logpath="c:\Windows\Temp"
Start-Transcript $logpath\AD-Install-$CurrentDate.txt 
Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
$Password = ConvertTo-SecureString  $args[0] -AsPlainText -Force
$dn= $args[1]
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath C:\Windows\NTDS -DomainName $dn -InstallDns:$true -LogPath C:\Windows\NTDS -NoRebootOnCompletion:$true -SafeModeAdministratorPassword $Password -SysvolPath C:\Windows\SYSVOL -Force:$true
Copy-Item C:\windows\PolicyDefinitions C:\Windows\SYSVOL\sysvol\$dn\Policies\ -Recurse -force
Stop-Transcript
