<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.


[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fmimorep%2FiTunesBridge&count_bg=%23555555&title_bg=%23555555&icon=mediafire.svg&icon_color=%23FF914C&title=Views&edge_flat=false)](https://hits.seeyoufarm.com) ![GitHub issues](https://img.shields.io/github/issues/mimorep/iTunesBridge) ![GitHub release (latest by date)](https://img.shields.io/github/v/release/mimorep/iTunesBridge) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/mimorep/iTunesBridge) ![GitHub all releases](https://img.shields.io/github/downloads/mimorep/iTunesBridge/total) 

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

<a href="https://www.buymeacoffee.com/M7Dev" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>
