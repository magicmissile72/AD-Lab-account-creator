# Name: Active Directory Lab Account Creater
# 1/22/20
# Current Version: 0.1
# 
# History
# V0.1 = Inital script is a manual process to create the account. Requires an AD domain to function (duh!)


# Import Required Modules
Import-Module ActiveDirectory

# Store Firstname into a variable (manual)
$firstname = Read-Host -Prompt "Enter First name"
$lastname = Read-Host -Prompt "Enter Last name"
$password = Read-Host -Prompt "enter your password"
$passcheck = Read-Host -Prompt "enter your password (again)"

# check if the passwords match, exit on fail
if (Compare-Object $password $passcheck)
{
    Write-Host "Your passwords do not match"
    exit
}

# Convert password to a secure string
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Output users information (debug)
#Write-Output "Your information"
#Write-Output "First name: $firstname"
#Write-Output "Last name: $lastname"
#Write-Output "Password: $password"
#Write-Output "The encrypted pass is: $securePassword"

# Specify where to store the account (i.e.what Organizational Unit)
# note: need to set this from an argument or ?
$OU_path = "OU='Organization Unit',DC=domain,DC=com"
#Write-Output $OU_path

# Create the new user
# note: change -ChangePasswordAtLogon to $True to have users forced to change password on login
New-ADUser -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surename $lastname `
    -UserPrincipleName "$firstname.$lastname" `
    -Path $OU_path `
    -AccountPassword $securePassword `
    -ChangePasswordAtLogon $False `
    -Enabled $True



#
