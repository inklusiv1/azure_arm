Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
$Password = Read-Host -Prompt 'Enter SafeMode Admin Password' -AsSecureString
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath C:\Windows\NTDS -DomainName $dn -InstallDns:$true -LogPath C:\Windows\NTDS -NoRebootOnCompletion:$true -SafeModeAdministratorPassword $Password -SysvolPath C:\Windows\SYSVOL -Force:$true
Copy-Item C:\windows\PolicyDefinitions C:\Windows\SYSVOL\sysvol\$dn\Policies\ -Recurse -force
