#############################################
#                ITunesBridger              #
#                   By M7                   #
#############################################

function CreateMenu 
{
    Clear-Host
    Write-Host "$Banner" -ForegroundColor Cyan
    Write-Host " "    
    Write-Host "Selected user: $UserToOperate" -ForegroundColor Yellow
    Write-Host " "    
    Write-Host "---------------------- Menu ----------------------"
    Write-Host "1. Create permanent Bridge"
    Write-Host "2. Create temporal Bridge"
    Write-Host "3. List Current output"
    Write-Host "0. Exit"
    Write-Host " "
}

# Main function for the Bridge creation
function CreateBridge
{
    param
    (
        [string] $ApplePath="",
        [string] $OutputLetter="",
        [bool] $Temporal=$false
    )

    # Check if the output exists
    If (Test-Path -Path $OutputLetter":\iTunesBridge") { }
    else
    {
        mkdir $OutputLetter":\iTunesBridge" > $null
    }

    $FolderContent = Get-ChildItem -Path $ApplePath -Force -Recurse -ErrorAction 'silentlycontinue' | Where { $_.Attributes -match "ReparsePoint"}

    If ($FolderContent.Length -gt 0)
    {
        If ($FolderContent[0].name -eq "Backup")
        {
            $UserResponse = Read-Host "Bridge already exists, Whant to delete it? (Y/N)"
            Write-Host " "
            If ($UserResponse -eq "Y")
            {
                Write-Warning "Creating a new bridge will delete all the backups!"
                Write-Host " "
                $UserResponse = Read-Host "Whant to save the data before creating a new Bridge? (Y/N)"
                If ($UserResponse -eq "Y")
                {
                    # Rename the folder to name-old, to save it
                    Rename-Item $ApplePath"\Backup" "Old-Backup"
                }
                else 
                {
                    # Delete the folder
                    Remove-Item $ApplePath"\Backup" -Recurse -Force
                }

                # Create the bridge
                New-Item -ItemType Junction -Path $ApplePath"\Backup" -Target $OutputLetter":\iTunesBridge"
                Write-Host ""
                Write-Host "Bridge created in"$OutputLetter":\iTunesBridge" -ForegroundColor Green

                If ($Temporal -eq $true)
                {
                    Write-Host " "
                    Write-Host "Press CTRL+C to stop and delete the bridge" -ForegroundColor Green
                    While ($true) {}
                } 
                else
                {
                    Break
                }               
            }
        }
        else
        {
            Write-Host "No bridges present for this user"
        }
    }
    else
    {
        # Empty folder
        # Create the bridge
        New-Item -ItemType Junction -Path $ApplePath"\Backup" -Target $OutputLetter":\iTunesBridge"
        Write-Host ""
        Write-Host "Bridge created in"$OutputLetter":\iTunesBridge" -ForegroundColor Green
        
        If ($Temporal -eq $true)
        {
            Write-Host " "
            Write-Host "Press CTRL+C to stop and delete the bridge" -ForegroundColor Green
            While ($true) {}
        } 
        else
        {
            Break
        }
    }
}

# Function for changing the path of the iTunes
function ChangePath 
{
    param ([bool]$temporal=$false)

    # Volume selection

    Write-Host "Disks of the system: "
    Write-Host ""

    Get-WmiObject -Class Win32_LogicalDisk | Format-Table DeviceId, VolumeName, @{n="FreeSpace (GB)";e={[math]::Round($_.FreeSpace/1GB,2)}}
    [int] $count = 0

    $OutputLetter = Read-Host "Select the DevideId"

    If ($temporal)
    {
        # Intercept Contrl + C
        try 
        {
            Write-Host " "
            $UserResponse = Read-Host "The temporal bridge will be created in the next path"$OutputLetter":\iTunesBridge is correct? (Y/N)"

            If ($UserResponse -eq "Y")
            {
                $ApplePath = "C:\Users\" + $UserToOperate + "\AppData\Roaming\Apple Computer\MobileSync"
                
                CreateBridge -ApplePath $ApplePath -OutputLetter $OutputLetter -Temporal $true                
            }
            else
            {
                ChangePath -Temporal $true
            }            
        }
        catch 
        {
            Write-Error "Error run the app again"
        }
        finally 
        {
            Write-Host " "
            Write-Warning "Deleting the Bridge"

            Remove-Item  $ApplePath"\Backup" -Recurse -Force

            Write-Host " "
            Write-Host "Temporal bridge deleted" -ForegroundColor Green
        }
        
    }
    else
    {
        # Permanent link
        Write-Host " "
        $UserResponse = Read-Host "The permanent bridge will be created in the next path"$OutputLetter":\iTunesBridge is correct? (Y/N)"
        If ($UserResponse -eq "Y")
        {
            Write-Host ""

            $ApplePath = "C:\Users\" + $UserToOperate + "\AppData\Roaming\Apple Computer\MobileSync"

            CreateBridge -ApplePath $ApplePath -OutputLetter $OutputLetter
        }
        else 
        {
            ChangePath -Temporal $false
        }
    }

}

# Function that changes the bridge icon
function ChangeIcon
{

}

# Funtion to list and select the user to operate with
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

    If ($FolderContent[0].name -eq "Backup")
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

# Function that checks the execution rights and opens a new instance If need it
function CheckRights 
{
    If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Write-Host " "
        Write-Warning "Not enought rights!" 
        Write-Warning "Opening a new window with eleveated rights" 
        Start-Process PowerShell -ArgumentList $PSCommandPath -Verb RunAs  
        Break 
    }
    else
    {
        Write-Host " "
        Write-Host "Elevated rights detected" -ForegroundColor Green
    }
}


[string]$Banner = "
    _  _____                             ___        _      _                    
    (_)/__   \ _   _  _ __    ___  ___   / __\ _ __ (_)  __| |  __ _   ___  _ __ 
    | |  / /\/| | | || '_ \  / _ \/ __| /__\//| '__|| | / _` | / _` | / _ \| '__|
    | | / /   | |_| || | | ||  __/\__ \/ \/  \| |   | || (_| || (_| ||  __/| |   
    |_| \/     \__,_||_| |_| \___||___/\_____/|_|   |_| \__,_| \__, | \___||_|   
                                                            |___/             
                            By M7 (Miguel Moreno Pastor)"

Clear-Host 

Write-Host $Banner -ForegroundColor Cyan

CheckRights

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

Write-Host " "
Write-Host "Happy houting :) you can suppport M7 here: https://ko-fi.com/m7dev"
