# V Rising Dedicated Server Instructions
The V Rising Dedicated Server is as it sounds a dedicated server application for the game [V Rising](https://store.steampowered.com/app/1604030/V_Rising/).

# Download
The V Rising Dedicated Server application can be downloaded from Steam, and is freely available to everyone. It can be found in the Tools section of your library. At the moment there is only a Windows version of the server available. Hopefully we can provide the Linux version soon.

If you are using [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD) to download and run the server, the Steam AppID for the V Rising Dedicated Server is `1829350`. This is used for downloading the server, but when running it, it will use the same Steam AppID as the client, which is defined in the `steam_appid.txt` file supplied with the download.

# Running the Server
In its simplest form you could just execute VRisingServer.exe to start the server. This will start the server with all default settings, which is probably not what you want.

There is an example batch script (`start_server_example.bat`) in the installation folder next to the executable file. It is recommended that you make a copy of this file and modify it to your liking. If you change the supplied example file it might be overwritten when the software is updated.

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

## Transfer local/client save to a Dedicated Server
The default location for save files, hosted via the game client, are:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRising\Saves`

In this folder there should currently only be one `v1` (at this time) folder, which represents the current `Persistence Version`. If in the future there are breaking changes to the persistence/save format, there could be `v2`, `v3`, et cetera.

Inside this (currently `v1`) folder lies the actual save folders for the local saves/sessions. Since the user does not name these session/save folders when starting/hosting a game via the game client, these folder names are random, in the GUID format. For example: `db4b1c0e-2b7d-430a-87ef-4b6c09398dcf`

Full path example:
```
%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRising\Saves\v1\db4b1c0e-2b7d-430a-87ef-4b6c09398dcf

AutoSave_0
AutoSave_1
AutoSave_2
ServerGameSettings.json
ServerHostSettings.json
SessionId.json
```

To find the specific session you want to move, you can check the `ServerHostSettings.json` file inside each folder to see the session name that you specified in-game.

When you have located the session you want to transfer to a dedicated server it is recommended to backup the full folder in case something goes wrong with the transfer on first try, so you allways have the original still.

Now when you have backed up the original, you can do a bit of cleaning up in this folder. If you have already set up your server with name, max players, password, et cetera, or supply them on the command line, then you can remove the `ServerHostSettings.json`. You can also remove all except the last `AutoSave_#` folder, since that is the one that will be loaded, but transferring them all is fine too. Rename the "GUID folder" to something simpler if you want to, then transfer it to the `.../Saves/v1/` folder on your server.

Configure the server to load the transferred save with the `-saveName <name>` command line parameter. Specify the moved folder as the save name to use. Also make sure to set `GameSettingsPreset` to be empty, so it does not load some other preset instead of the settings you have copied. Make sure to not have a modified `ServerGameSettings.json` in the default settings folder (should not be modified, as mentioned above) or any override `ServerGameSettings.json` in the local override folder, to achieve the same end result of game settings as they were when hosted via the client.

Lastly, it is recommended to remove the files moved/copied to the server from their original client location, so the same save/session does not show up twice when you have played on the server save.

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

#Admin commands

adminauth - Authenticate to gain administrator privileges
admindeauth - Relinquish your administrator privileges, if you have any
addtime <1-12> - Adds up to 12 in game hours to the current game time 
adminonlydebugevent - Set if debug events are limited to only admins
bancharacter <name> - Bans the user playing with the specified character name form the server
banned - List all banned players
banuser <Steam ID> - Bans the user with the specified steam ID from the server
changedurability (Amount, EquipmentType) - Do a durability change on equipped items
changehealthofclosesttomouse - Changes health by generating an actual HealthChangeEvent instead of a regular set
DebugViewEnabled - Enable or disable the debug view
GatherAllAllies - Teleports all allies to mouse cursor position
GatherAllAlliesExceptMe - Teleports all allies, except you, to mouse cursor position
GatherAllNonAllies - Teleports all non allies to mouse cursor position
GatherAllPlayers - Teleports all players to mouse cursor position
GatherAllPlayersExceptMe - Teleports all players, except you, to mouse cursor position
give (What, Amount) - Gives you the specified item in the specified amount	
giveset <setname> - Gives you the specified gear set
kick <Name> - Kicks a player from the server
listusers - List users that are active on the server (include disconnected players)
PlayerTeleport - Teleports you to your mouse cursor
setadminlevel <player name> <admin type> - Set or change the Admin level of a user (None, Moderator, Admin, Superadmin)
teleport (Who, Where, WorldPosX, WorldPosY) - Teleport something to a somewhere
TeleportPlayerToMe (User) - Teleport a player to your location
TeleportToChunk (Unnamed Argument) - Teleport player to chunk coordinate
TeleportToChunckWaypoint (Unnamed Argument) - Teleport to Chunck Waypoint
TeleportToNether - Teleports you to Nether (the first place you start from right after you create a character on the server)
TeleportToPlayer (User) - Teleport to Player location
toggleobserve (mode) - Toggle being observer (0 = turn off, 1 = Completely invisible, 2 = Ghost mode - you can go through walls)
