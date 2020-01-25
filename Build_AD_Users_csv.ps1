# Script to read in data from a CSV (, delineated file) and build user accounts...
#
# Note: Set-ExecutionPolicy Unrestricted
#
# CSV file format example:
# First Name,Last Name,Job Title,Office Phone,Email Address,Description,Organization Unit
# James,Smith,CEO,555-989-1001,empty field,empty field,"OU=Office,OU=CORP,DC=Megacorp,DC=com"

# temporary comment
#Import-Module ActiveDirectory

# Get CSV file path
$filepath = Read-Host -Prompt "Locate CSV file:"

# Import the file into a variable (i.e. C:\Code\AD_user_database.csv)
$users = Import-Csv $filepath

# Loop through each grow and collect info
foreach ($user in $users) {

    # Gather the iser's information
    $fname = $user.'First Name'
    $lname = $user.'Last Name'
    $password = $user.'password'
    $jobTitle = $user.'Job Title'
    $officePhone = $user.'Office Phone'
    $email = $user.'Email Address'
    $description = $user.'Description'
    $OUpath = $user.'Organization Unit'

    # Convert password to a secure string
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force

    # Create new AD user for each user in the CSV file
    New-ADUser -Name "$fname $lname" `
        -GivenName $fname `
        -Surname $lname `
        -UserPrincipleName "$fname.$lname" `
        -Path $OUpath `
        -AccountPassword $securePassword `
        -ChangePasswordAtLogon $False `
        -EmailAdress $email `
        -OfficePhone $officePhone `
        -Description $description `
        -Enabled $True



    #Write-Output $fname
    Write-Output "Account created for $fname $lname in $OUpath"

}

# EOF