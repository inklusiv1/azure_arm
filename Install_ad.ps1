Add-WindowsFeature AD-Domain-Services -IncludeManagementTools
$Password = $args[0]
$dn= $args[1]
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath C:\Windows\NTDS -DomainName $dn -InstallDns:$true -LogPath C:\Windows\NTDS -NoRebootOnCompletion:$true -SafeModeAdministratorPassword $Password -SysvolPath C:\Windows\SYSVOL -Force:$true
Copy-Item C:\windows\PolicyDefinitions C:\Windows\SYSVOL\sysvol\$dn\Policies\ -Recurse -force
