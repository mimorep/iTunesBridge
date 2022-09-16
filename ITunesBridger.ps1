# TODO: Home
# TODO: Preguntar por version del itunes
# TODO: Mostrar el path de salida actual
# TODO: Preguntar por cambio de path
# TODO: Listado de dispositivos
# TODO: 


# [System.IO.DriveInfo]::GetDrives() | Format-Table 

function CreateMenu 
{
    Clear-Host
    Write-Host "$Banner"
    Write-Host " "    
    Write-Host "Selected user: $UserToOperate"
    Write-Host " "    
    Write-Host "---------------------- Menu ----------------------"
    Write-Host "1. Create permanent Bridge"
    Write-Host "2. Create temporal Bridge"
    Write-Host "3. List Current output"
    Write-Host "0. Exit"
    Write-Host " "
}

# Function for changing the path of the iTunes
function ChangePath 
{
    param ([bool]$temporal=$false)

    # Volume selection

    Write-Host "Disks of the system: "
    Write-Host ""

    $Disks = Get-WmiObject -Class Win32_LogicalDisk | ? {$_.DriveType -eq 3} | Format-Table DeviceId, VolumeName, @{n="FreeSpace (GB)";e={[math]::Round($_.FreeSpace/1GB,2)}}
    [int] $count = 0

    if ($temporal)
    {
        # Finally statement for capturing the exit
        try
        {            
            
        }
        finally
        {
            
        }
    }
    else
    {
        
    }

}

function UserSelection 
{
    Write-Host " "

    [int] $count = 0
    $Users = Get-ChildItem C:\Users 

    ForEach ($user In $Users)
    {
        Write-Host $count $user
        $count = $count + 1
    }

    Write-Host " "
    $UserIndex = Read-Host "Select the user to change: "
    Write-Host " "

    return $Users[$UserIndex]
}

# Gets the path for the current user
function GetPath
{
    $ApplePath = "C:\Users\" + $UserToOperate + "\AppData\Roaming\Apple Computer\MobileSync"
    $FolderContent = Get-ChildItem -Path $ApplePath -Force -Recurse -ErrorAction 'silentlycontinue' | Where { $_.Attributes -match "ReparsePoint"}

    if ($FolderContent[0].name -eq "Backup")
    {
          Write-Host " "
          Write-Host "You have a bridge to:" $FolderContent[0].Target
          Write-Host " "
    }
    else
    {
        Write-Host "No bridges present for this user"
    }

}


[string]$Banner = "
    _  _____                             ___        _      _                    
    (_)/__   \ _   _  _ __    ___  ___   / __\ _ __ (_)  __| |  __ _   ___  _ __ 
    | |  / /\/| | | || '_ \  / _ \/ __| /__\//| '__|| | / _` | / _` | / _ \| '__|
    | | / /   | |_| || | | ||  __/\__ \/ \/  \| |   | || (_| || (_| ||  __/| |   
    |_| \/     \__,_||_| |_| \___||___/\_____/|_|   |_| \__,_| \__, | \___||_|   
                                                            |___/             "

Clear-Host
Write-Host "$Banner"
$UserToOperate = UserSelection

do 
{
    CreateMenu
    $UserInput = Read-Host "Select an option: "
    
    switch ($UserInput)
    {
        '1' { ChangePath -Temporal $false }
        '2' { ChangePath -Temporal $true }
        '3' { GetPath }
    }
    pause

}
until ($UserInput -eq "0")
