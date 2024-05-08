# V Rising Dedicated Server Instructions for v0.5.x

> [!NOTE]
> These instructions are for the original Early Access version (`0.5.x`) of the V Rising Dedicated Server.  
>
> Links to instructions for other versions can be found in the top level [README](../README.md) file.

The V Rising Dedicated Server is the server application for the game [V Rising](https://store.steampowered.com/app/1604030/V_Rising/).

# Download
The V Rising Dedicated Server application can be downloaded from Steam, and is freely available to everyone. It can be found in the Tools section of your library. At the moment there is only a Windows version of the server available.

This version of the V Rising Dedicated server can be downloaded from the `legacy-0.5.x` branch.

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

## Server Host Settings
Below you can find the settings in `ServerHostSettings.json`.

The `Setting: KeyWord` refers to the name/key in the JSON file.

Each setting can be overridden via an Environment Variable (System, User, Process) or Command Line Parameter, in this order (if multiple were to be used/stacked). In the `Overrides` list, the environment variables are written in upper case like `VR_EXAMPLE=<value>`, and the command line parameters are written as `-commandLineExample <value>`.

Setting: `Name`  
Description: Name of the server. The name that shows up in server list.  
Type: `text`  
Example value: `"My V Rising Server"`  
Overrides: `VR_NAME=<name>`, `VR_SERVER_NAME=<name>`, `-serverName <name>`  

---

Setting: `Description`  
Description: Short server description. Shows up in details panel of server list when entry is selected. Also printed in chat when connecting to server.  
Type: `text`  
Example value: `"Role playing server. Reset every Monday. Be nice."`  
Overrides: `VR_DESCRIPTION=<description>`, `-description <description>`  

---

Setting: `Port`  
Description: UDP port for game traffic.  
Type: `number`  
Example value: `27015`  
Overrides: `VR_GAME_PORT=<port>`, `-serverPort <port>` (deprecated), `-gamePort <port>`  

---

Setting: `QueryPort`  
Description: UDP port for Steam server list features.  
Type: `number`  
Example value: `27016`  
Overrides: `VR_QUERY_PORT=<port>`, `-queryPort <port>`  

---

Setting: `Address`  
Description: Bind to a specific IP address.  
Type: `text`  
Example value: `10.20.0.3`  
Overrides: `VR_ADDRESS=<address>`, `VR_BIND_ADDRESS=<address>`, `-address <address>`, `-bindAddress <address>`  

---

Setting: `MaxConnectedUsers`  
Description: Max number of concurrent players on server.  
Type: `number`  
Example value: `40`  
Overrides: `VR_MAX_USERS=<number>`, `-maxConnectedUsers <number>` (deprecated), `-maxUsers <number>`  

---

Setting: `MaxConnectedAdmins`  
Description: Max number of admins to allow connect even when server is full.  
Type: `number`  
Example value: `4`  
Overrides: `VR_MAX_ADMINS=<number>`, `-maxConnectedAdmins <number>` (deprecated), `-maxAdmins <number>`  

---

Setting: `ServerFps`  
Description: Target FPS for server.  
Type: `number`  
Example value: `30`  
Overrides: `VR_FPS=<fps>`, `VR_TARGET_FPS=<fps>`, `-fps <fps>`, `-targetFps <fps>`, `-serverFps <fps>`  

---

Setting: `Password`  
Description: Set a password or leave empty.  
Type: `text`  
Example value: `SuperSecret`  
Overrides: `VR_PASSWORD=<password>`, `-password "<password>"`  

---

Setting: `Secure`  
Description: Enable VAC protection on server. VAC banned clients will not be able to connect.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_SECURE=<value>`, `-secure <value>`, `-enableSecure`, `-disableSecure`  

---

Setting: `ListOnMasterServer`  
Description: Register on list server or not.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_LIST_ON_MASTER_SERVER=<value>`, `-listing <value>`, `-enableListing`, `-disableListing`

---

Setting: `GameSettingsPreset`  
Description: Load a ServerGameSettings preset.  
Type: `text`  
Example value: `StandardPvP`  
Overrides: `VR_PRESET=<preset>`, `-preset <preset>`  

---

Setting: `SaveName`  
Description: Name of save file/directory. Must be a valid directory name.  
Type: `text`  
Example value: `world23`  
Overrides: `VR_SAVE_NAME=<name>`, `-serverSaveName <name>` (deprecated), `-saveName <name>`  

---

Setting: `AutoSaveCount`  
Description: Number of autosaves to keep.  
Type: `number`  
Example value: `20`  
Overrides: `VR_SAVE_COUNT=<number>`, `-saveCount <number>`

---

Setting: `AutoSaveInterval`  
Description: Interval in seconds between each auto save.  
Type: `number`  
Example value: `120`  
Overrides: `VR_SAVE_INTERVAL=<number>`, `-saveInterval <number>`  

---

Setting: `LanMode`  
Description: Enable LAN mode.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_LAN_MODE=<value>`, `-lanMode <value>`, `-lan`, `-enableLanMode`, `-disableLanMode`  

---

Setting: `ResetDaysInterval`  
Description: Days between scheduled resets/wipes. When the server starts, and is about to load a save file, it checks if it is time to reset and start a new save file. The previous save file is backed up. Defaults to `0`, which means the feature is disabled.  
Type: `number`  
Example values: `0`, `7`, `14`, `37`  
Overrides: `VR_RESET_DAYS_INTERVAL=<value>`, `-resetDaysInterval <value>`  

---

Setting: `DayOfReset`  
Description: If you want the server to reset on Saturdays, every two weeks, but it is not Saturday when you initially set up you server then you can set `ResetDaysInterval` to `14` and then set this to `Saturday`. It will check that at least `ResetDaysInterval` days has passed and that it is the day of `DayOfReset`. If you do not want to restrict reset to a specific day, but just rely on the value of `ResetDaysInterval`, then set this to `Any`, which is also the default.  
Type: `enum`  
Possible values: `Any`, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`  
Overrides: `VR_DAY_OF_RESET=<value>`, `-dayOfReset <value>`  

---

### Rcon

Setting: `Enabled`  
Description: Enable or disable Rcon functionality.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_RCON_ENABLED=<value>`, `-rconEnabled <value>`, `-enableRcon`, `-disableRcon`  

---

Setting: `Port`  
Description: Rcon TCP port.  
Type: `number`  
Example value: `25575`  
Overrides: `VR_RCON_PORT=<port>`, `-rconPort <port>`  

---

Setting: `Password`  
Description: Password to access RCON.  
Type: `text`  
Example value: `ExtraSecretPassword`  
Overrides: `VR_RCON_PASSWORD="<password>"`, `-rconPassword "<password>"`

---

Setting: `BindAddress`  
Description: Binds RCON socket to specified address. Will override the "global" `Address` setting, if you want to bind to a separate internal interface for instance.  
Type: `text`  
Example value: `10.22.0.8`  
Overrides: `VR_RCON_BIND_ADDRESS="<address>"`, `-rconBindAddress "<address>"`

## Firewall / Port Forwarding
If you want others to connect to your server, make sure you allow the program through the firewall. You might also need to forward ports on your router. To do this, please follow your manufacturer's instructions for your particular router.
If you want your server to show up on the server list you need to make sure that both the specified queryPort and gamePort is open in your firewall and forwarded on your router, otherwise just opening/forwarding the gamePort will be enough.

## Server Administration
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
```json
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
