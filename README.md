
- [V Rising Dedicated Server](#v-rising-dedicated-server)
- [Required System Specifications](#required-system-specifications)
  - [Small Server Instance (~10 users)](#small-server-instance-10-users)
- [Supported Platforms](#supported-platforms)
- [Installation](#installation)
  - [Installation through Steam](#installation-through-steam)
  - [Installation through SteamCMD](#installation-through-steamcmd)
  - [Installation and Update with SteamPS](#installation-and-update-with-steamps)
    - [Process](#process)
    - [Process to update the game using SteamPS](#process-to-update-the-game-using-steamps)
- [Running the Server](#running-the-server)
- [Configuring the Server](#configuring-the-server)
- [Save Files](#save-files)
  - [Backups](#backups)
- [RCON](#rcon)

# V Rising Dedicated Server
The V Rising Dedicated Server is a dedicated server application for the game [V Rising](https://store.steampowered.com/app/1604030/V_Rising/).

# Required System Specifications
## Small Server Instance (~10 users)
* 6GB of RAM
* 2 CPU Cores 

# Supported Platforms
* Windows
* Linux / Docker are not supported at this time
  * Hopefully a Linux version will come out soon!

# Installation

## Installation through Steam
The V Rising Dedicated Server application can be downloaded from Steam, and is freely available to everyone. It can be found in the Tools section of your library named "`V Rising Dedicated Server`"

## Installation through SteamCMD
If you are using [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) to download and run the server, the Steam AppID for the V Rising Dedicated Server is `1829350`. This is used for downloading the server, but when running it, it will use the same Steam AppID as the client, which is defined in the `steam_appid.txt` file supplied with the download.

## Installation and Update with SteamPS
You can also use a wrapper for SteamCMD called [SteamPS] (https://github.com/hjorslev/SteamPS) which will manage the installation and update of the server assets.

### Process
* Click on `Start`
* Type `cmd` and press enter
* Issue the command `powershell`
* Run the following commands to install the module, then install the game into `C:\servers\v_rising` you may change this directory to your preferance.
    ```powershell
    Install-Module -Name SteamPS
    Install-SteamCMD
    Update-SteamApp -ApplicationName 'V Rising Dedicated Server' -Path 'C:\servers\v_rising'
    ```
    **NOTE:** Any questions should be answered with yes

### Process to update the game using SteamPS
* Click on `Start`
* Type `cmd` and press enter
* Issue the command `powershell`
* Run the following command `Update-SteamApp -ApplicationName 'V Rising Dedicated Server' -Path 'C:\servers\v_rising'` to update the game in `C:\servers\v_rising` you may change this directory to your currently installed dedicated game server path.  
**NOTE:** Any questions should be answered with yes

# Running the Server
In its simplest form you could just execute VRisingServer.exe to start the server. This will start the server with all default settings, which is probably not what you want.

There is an example batch script (`start_server_example.bat`) in the installation folder with the executable file. It is recommended that you make a copy of this file and modify it to your liking. (IE: `start_server.bat`)  
**NOTE:** If you change the supplied example file (`start_server_example.bat`) it might be overwritten when the software is updated!

# Configuring the Server
There are two main settings files that the server is using.
* `ServerHostSettings.json`
* `ServerGameSettings.json`

As the names suggest, one of them is for hosting related settings and the other one is for game play related settings.

The default settings of these can be found in `VRisingServer_Data/StreamingAssets/Settings/`. While you could modify these files, just like with the example start script, it is for the same reason not recommended to do this.

After the server has loaded the default files it looks for local overrides. The default location it looks for these files are:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRisingServer\Settings`

You can put a full settings file in this local override location, or you can populate it with just the settings/values that differ from the default file.

This location can be customized with the `-persistentDataPath` parameter, which is recommended to do in general and a must if you want to run multiple servers on one host to keep the settings and saves separated.

**NOTE**: The path that is replaced with `-persistentDataPath` is what the [`Application.persistentDataPath`](https://docs.unity3d.com/ScriptReference/Application-persistentDataPath.html) constant in [Unity](https://unity.com/) is referring to, which is:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRisingServer\`

That means that anything that would have gone inside the path above, like `Settings` and `Saves` goes below/inside whatever folder specified with `-persistentDataPath`. So settings files are read from the `Settings` subfolder and saves are put in the `Saves` subfolder within the specified path.

The most important settings in the `ServerHostSettings.json` file are the following:

| Setting | Value Type | Example Value | Comment |
|----------|:-------------:|:------:|---|
| Name | string | "My V Rising Server" | Name of server |
| Description | string | "This is a role playing server" | Short description of server purpose, rules, message of the day |
| Port | number | 27015 | UDP port for game traffic |
| QueryPort | number | 27016 | UDP port for Steam server list features |
| MaxConnectedUsers | number | 10 | Max number of concurrent players on server |
| MaxConnectedAdmins | number | 4 | Max number of admins to allow connect even when server is full |
| SaveName | string | "world1" | Name of save file/directory |
| Password | string | "SuperSecret" | Set a password or leave empty |
| ListOnMasterServer | boolean | true | Set to true to list on server list, else set to false |
| AutoSaveCount | number | 40 | Number of autosaves to keep |
| AutoSaveInterval | number | 120 | Interval in seconds between each auto save |
| GameSettingsPreset | string | "StandardPvP" | Name of a GameSettings preset found in the GameSettingPresets folder |

Some settings can be overwritten by command line parameters. Below is a list of some of the parameters that can be used.

| Parameter | Value Type | Example Value | Comment |
|----------|:-------------:|:------:|---|
| -saveName | string | "world1" | Name of save file/directory |
| -serverName | string | "My V Rising Server" | Name of server in server list |
| -persistentDataPath | string | ".\save-data" | Absolute or relative path to where Settings and Save files are held |
| -maxConnectedUsers | number | 10 | Max number of concurrent players on server |
| -maxConnectedAdmins | number | 4 | Max number of admins to allow connect even when server is full |
| -address | string | "127.0.0.1" | Bind to a specific IP address |
| -gamePort | number | 27015 | UDP port for game traffic |
| -queryPort | number | 27016 | UDP port for Steam server list features |

If you want others to connect to your server, make sure you allow the program through the firewall. You might also need to forward ports on your router. To do this, please follow your manufacturer's instructions for your particular router.
If you want your server to show up on the server list you need to make sure that both the specified queryPort and gamePort is open in your firewall and forwarded on your router, otherwise just opening/forwarding the gamePort will be enough.

To become an administrator in the game you will first need to modify the `adminlist.txt` file under `VRisingServer_Data/StreamingAssets/Settings/` with your steamId (one steamId per line). This can be done without restarting your server. To become an administrator in the game you need to enable the console in the options menu, bring it down with `~` and authenticate using the `adminauth` console command. Once an administrator you can use a number of administrative commands like `banuser`, `bancharacter`, `banned`, `unban` and `kick`.

If you ban users through the in-game console the server will automatically modify the `banlist.txt` located under `VRisingServer_Data/StreamingAssets/Settings/` but you can also modify this manually (one steamId per line).

# Save Files
The default location for save files are:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRisingServer\Saves`

However, just like with the settings, this can be overridden with the `-persistentDataPath` parameter. As explained above, the saves will put in the `Saves` subfolder of whatever path is specificed by `-persistentDataPath`.

## Backups
It is highly recommended to backup the save files often and before patching or before starting the server after having patched.

The current auto save settings allows you to set save interval and save count. So with the same amount of disk space you either save often but maybe not have that many save files (not so far back in time), or save less often (longer rollback in-case of crash) and have more save files, or high number of on both and consume more disk space. So, again, regularly backing up you save files is highly recommended in case your game state becomes corrupted.

 # RCON
Altough currently with limited functionality, you can configure the server to listen to RCON connections. If you are not familiar with RCON you can read more about it here: https://developer.valvesoftware.com/wiki/Source_RCON_Protocol.

To enable RCON, add the following to the server host settings file (located at `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRisingServer\ServerHostSettings.json` on windows):
```
"Rcon": {
  "Enabled": true,
  "Password": "somepassword",
  "Port": 25575
}
```

Note that a password must be configured, this cannot be left empty. Port can be changed to any valid TCP port.
  
These are the currently available commands:

| Command | Parameter | Comment |
|------|:-------------:|:------|
| announce | string | Sends a message to all players connected to the server. |
| announcerestart | number | Sends a pre-configured message that announces server restart in x minutes to all players connected to the server. Less flexible than announce but has the benefit of being localized to each users language. |

To connect to the server you need an RCON client. There are multiple available, one known to work with V Rising is https://github.com/Tiiffi/mcrcon.
