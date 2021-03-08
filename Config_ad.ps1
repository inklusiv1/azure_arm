$path= (get-addomain).DistinguishedName
New-ADOrganizationalUnit -Name "Accounts" -path $path
New-ADOrganizationalUnit -Name "Admin accounts" -path "OU=Accounts,$path"
New-ADOrganizationalUnit -Name "Groups" -path "OU=Accounts,$path"
New-ADOrganizationalUnit -Name "Local Admin Groups" -path "OU=Accounts,$path"
New-ADOrganizationalUnit -Name "Technical Accounts" -path "OU=Accounts,$path"
New-ADOrganizationalUnit -Name "Servers" -path $path

$user1name=$args[0]
$user1givename=$args[1]
$user1sam=$args[2]
$user1upn=$args[3]
$user1pass=ConvertTo-SecureString  $args[4] -AsPlainText -Force

New-ADUser -Name "$user1name $user1givename" -GivenName "$user1givename" -Surname "$user1name" -SamAccountName "$user1sam" -UserPrincipalName "$user1upn" -Path "OU=Admin accounts,OU=Accounts,$path" -AccountPassword $user1pass -Enabled $true

Add-ADGroupMember -Identity "domain admins" -Members $user1sam

$upn=(Get-adforest).name
$user2pass=ConvertTo-SecureString  $args[5] -AsPlainText -Force
$user3pass=ConvertTo-SecureString  $args[6] -AsPlainText -Force
$sqlserver=$args[7]

New-ADUser -Name "#IIS-XcpApp" -SamAccountName "#IIS-XcpApp" -UserPrincipalName "#IIS-XcpApp@$upn" -Path "OU=Technical Accounts,OU=Accounts,$path" -AccountPassword $user2pass -Enabled $true -PasswordNeverExpires $true -Description "IIS appplication pool"

New-ADUser -Name "#SQL-$sqlserver"  -SamAccountName "#SQL-$sqlserver" -UserPrincipalName "#SQL-$sqlserver@$upn" -Path "OU=Technical Accounts,OU=Accounts,$path" -AccountPassword $user3pass -Enabled $true -PasswordNeverExpires $true -Description "Sql server agent"

New-ADGroup -Name "SQL-DBA-$sqlserver" -SamAccountName "SQL-DBA-$sqlserver" -GroupCategory Security -GroupScope Global -DisplayName "SQl-DBA-Administrators" -Path "OU=Groups,OU=Accounts,$path" -Description "DBA for $sqlserver"

New-ADGroup -Name "SQLServerAdmins" -SamAccountName SQLServerAdmins -GroupCategory Security -GroupScope Global -DisplayName "SQL Administrators" -Path "OU=Groups,OU=Accounts,$path" -Description "Global SQL Administrators"


