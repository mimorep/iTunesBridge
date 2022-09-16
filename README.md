# iTunesBridge

ITunesBridge is a PowerShell script that is able to generate a temporal o permanent bridge, in order to change the iTunes backup output.

![image](https://user-images.githubusercontent.com/43792651/190635373-6e294439-8f2a-42ab-b068-575a59f1a6c1.png)

# Installation

In order to get this program working, clone this repository if you want the raw PowerShell script.

```
git clone https://github.com/mimorep/iTunesBridge.git

cd iTunesBridge

.\ITunesBridger.ps1
```

If you want to get the *.exe* binary, just go to the [release] section and donwload it.

[release]: https://github.com/mimorep/iTunesBridge/releases

# Usage Recomendations

Depending of what you want to perform, you should use diferent options

## User selection

By default iTunes saves the backups in a folder inside the *AppData* folder. Because of that you must select at the start of the application the user you want to create the bridge for.

## Temporal links

This will create a brigde, but it will be destroyed, after closing the program or pressing Ctrl + C. These are designer to point to remobable drives.

## Permanent links

This links will not be destroyed after closing the program. These are designed to change the default output of iTunes, not recommended to create a permanent link into a remobable drive.

## List Current Output

This will show were the current bridge  is created.

***Note that in case of having a temporal one, this option will only be able to run by another program instance.***

# RoadBook

- [:white_check_mark:] Banner and Menu
- [:white_check_mark:] List of the device users
- [:white_check_mark:] Get the current bridge (if exists)
- [:white_check_mark:] Creation of the permanent link
- [:white_check_mark:] Creation of the temporal link
- [:white_check_mark:] Colors for the interface
- [:heavy_exclamation_mark:] Create a release version

# Support

If you liked the project and want to have an account, you can support my work here:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/C0C1EGEYL)
