# V Rising Dedicated Server Instructions for v1.0.x

> [!NOTE]
> These instructions are for the Release (1.0) version (`1.0.x`) of the V Rising Dedicated Server.  
>
> Links to instructions for other versions can be found in the top level [README](../README.md) file.

The V Rising Dedicated Server is the server application for the game [V Rising](https://store.steampowered.com/app/1604030/V_Rising/).

# Download
The V Rising Dedicated Server application can be downloaded from Steam, and is freely available to everyone. It can be found in the Tools section of your library. At the moment there is only a Windows version of the server available.

This version of the V Rising Dedicated server can be downloaded from the `legacy-1.0.x-pc` branch.

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

Setting: `HideIPAddress`  
Description: When listing server on EOS server list, the IP address will not be shown/advertised. Players will connect via relay servers.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_HIDEIPADDRESS=<value>`, `VR_HIDE_IP_ADDRESS=<value>`, `-hideIpAddress <value>`  

---

Setting: `MaxConnectedUsers`  
Description: Max number of concurrent players on server. The maximum number technically supported is `128`.  
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

Setting: `LowerFPSWhenEmpty`  
Description: Run the server at a lower framerate target when no players are logged in.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_LOWER_FPS_WHEN_EMPTY=<value>`, `-lowerFPSWhenEmpty <value>`  

---

Setting: `LowerFPSWhenEmptyValue`  
Description: Set the framerate target for when `LowerFPSWhenEmpty` is active.  
Type: `number`  
Example value: `15`, `10`, `5`  
Overrides: `VR_LOWER_FPS_WHEN_EMPTY_VALUE=<value>`, `-lowerFPSWhenEmptyValue <value>`  

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

Setting: `ListOnEOS`  
Description: Register on EOS list server or not. The client looks for servers here by default, due to additional features available.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_LIST_ON_EOS=<value>`, `-listOnEOS <value>`  

---

Setting: `ListOnSteam`  
Description: Register on Steam list server or not.  
Type: `boolean`  
Example value: `true`, `false`  
Overrides: `VR_LIST_ON_STEAM=<value>`, `-listOnSteam <value>`  

---

Setting: `GameSettingsPreset`  
Description: Load a ServerGameSettings preset.  
Type: `text`  
Example value: `StandardPvP`  
Overrides: `VR_PRESET=<preset>`, `-preset <preset>`  

These presets can be found in the `VRisingServer_Data/StreamingAssets/GameSettingPresets` folder.

---

Setting: `GameDifficultyPreset`  
Description: Load a GameDifficulty preset.  
Type: `text`  
Example value: `Difficulty_Easy`, `Difficulty_Normal`, `Difficulty_Brutal`  
Overrides: `VR_DIFFICULTY_PRESET=<preset>`, `-difficultyPreset <preset>`  

These presets can be found in the `VRisingServer_Data/StreamingAssets/GameDifficultyPresets` folder.

---

Setting: `SaveName`  
Description: Name of save file/directory. Must be a valid directory name.  
Type: `text`  
Example value: `world23`  
Overrides: `VR_SAVE_NAME=<name>`, `-serverSaveName <name>` (deprecated), `-saveName <name>`  

---

Setting: `AutoSaveCount`  
Description: Total number of Auto Saves to keep.  
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

Setting: `AutoSaveSmartKeep`  
Description: Decides which saves to keep over time, in a "smarter" way than just the last `AutoSaveCount` number.  
Type: `string`  
Example value: `10:1:1,30:0:1,60:0:1,120:0:1,180:0:1,240:0:1,360:0:1,720:0:1,1440:0:1,2880:0:1,52560000:99:0`  
Overrides: `VR_AUTOSAVESMARTKEEP=<string>`, `-saveSmartKeep <string>`  

See the [AutoSaveSmartKeep and AutoSaveCount Settings](#autosavesmartkeep-and-autosavecount-settings) section for more details about the format of the `AutoSaveSmartKeep` setting and how it works together with `AutoSaveCount`.  

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
To become an administrator in the game you will first need to modify the `adminlist.txt` file in the `<PersistentDataPath>/Settings/` folder with your steamId (one steamId per line). This can be done without restarting your server. To become an administrator in the game you need to enable the console in the options menu, bring it down with `~` and authenticate using the `adminauth` console command. Once an administrator you can use a number of administrative commands like `banuser`, `bancharacter`, `banned`, `unban` and `kick`.

If you ban users through the in-game console the server will automatically modify the `banlist.txt` located under `<PersistentDataPath>/Settings/` but you can also modify this manually (one steamId per line).

# Save Files
The default location for save files are:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRisingServer\Saves`

However, just like with the settings, this can (and should) be overridden with the `-persistentDataPath` parameter. As explained above, the saves will put in the `Saves` subfolder of whatever path is specificed by `-persistentDataPath`.

## AutoSaveSmartKeep and AutoSaveCount Settings

The idea with `AutoSaveSmartKeep` is to be able to save often, lets say once every minute, but not just have saves from the past `30` minutes, if `AutoSaveCount` is set to `30`. It can for instance be configured to keep `3` saves from the past `10` minutes, `1` save from the past hour, two hours, six hours, then one for the past day, with a large "bucket" at the end gathering up all the once-per-day saves.

The reson to have a larger timespan of saves is it gives you more flexibility to choose a save to revert to in case you need or want to, for whatever reason. Also gives you a bit more time to react. As also mentioned below, backups are still always recommended as well.

The format of the `AutoSaveSmartKeep` setting value is as follows: `A:B:C,A:B:C,A:B:C,...`

It is a repeating set of values (a list) of `A`, `B`, and `C`, separated by a colon (`:`). Each of these sets are separated by a comma (`,`).

Where `A`, `B`, and `C` are:  
* `A` = Time in minutes before `now` (time of evaluation). Defining a time frame between `now` and `A` minutes ago.
* `B` = Number of newest/latest saves falling within this time frame to keep.
* `C` = Number of oldest saves within this time frame to keep.

Example: `10:2,1`
* Within the past `10` minutes, keep the most recent save, and the oldest save.

Depending on the time between auto saves, and the time gap between entries in this setting, it is usually a good idea to always save at least `1` of the oldest in each time slot defined. So it can eventually move on to the next time slot and be evaluated there.

Example: `10:2:1,60:0:1`
* Continuing from the previous example, this one adds a time frame that keeps the oldest save from the past `1` hour as well. Note that each time frame is adjusted to not include any previous time frame, so it will technically keep one save between `10-60` minutes ago.

Example: `10:2:1,60:0:1,120:0:1`
* Again continuing from the previous example, this one adds a time frame that keeps the oldest save from the past `2` hours as well. Again, note that this is now technically the time frame between `60-120` minutes ago.

### AutoSaveCount

After `AutoSaveSmartKeep` has been evaluated, which happens at each Auto Save, `AutoSaveCount` is applied and the oldest saves are removed until there are no more that `AutoSaveCount` number of saves left.

If you only want to use `AutoSaveCount`, set `AutoSaveSmartKeep` to an empty value, or confgure it to for exampel keep `100` of the most recent saves in the past `100` years as the only entry.

## Backups
It is highly recommended to backup the save files often and before patching or before starting the server after having patched.

Reasons for keeping backups of your saves includes:
* Protect from hardware failures.
* In case you lose your cloud server (or similar), or want to decomission it and return later.
* In case a bug cause some corrupted save state.

## Transfer local/client save to a Dedicated Server
The default location for save files, hosted via the game client, are:
* Windows: `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRising\CloudSaves\<SteamID>\`, or `%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRising\Saves\`

In this folder, running this version of the server, there should be a `v3` folder, which represents the current `Persistence Version`. This number changes whenever there are  breaking changes to the persistence/save format.

Inside this (currently `v3`) folder lies the actual save files for the local saves/sessions. Since the user does not name these session/save folders when starting/hosting a game via the game client, these folder names are random, in the GUID format. For example: `db4b1c0e-2b7d-430a-87ef-4b6c09398dcf`

Full path example:
```
%USERPROFILE%\AppData\LocalLow\Stunlock Studios\VRising\CloudSaves\<SteamID>\v3\db4b1c0e-2b7d-430a-87ef-4b6c09398dcf

AutoSave_0.save.gz
AutoSave_1.save.gz
AutoSave_2.save.gz
ServerGameSettings.json
ServerHostSettings.json
SessionId.json
StartDate.json
```

To find the specific session you want to move, find the save entry in the in-game `Load Game` menu and select `Go to Directory` and the directory will be opened up in a File Explorer window.

When you have located the session you want to transfer to a dedicated server it is recommended to backup the full folder in case something goes wrong with the transfer on first try, so you allways have the original still.

Now when you have backed up the original, you can do a bit of cleaning up in this folder. If you have already set up your server with name, max players, password, et cetera, or supply them on the command line, then you can remove the `ServerHostSettings.json`. You can also remove all except the last `AutoSave_#` folder, since that is the one that will be loaded, but transferring them all is fine too. Rename the "GUID folder" to something simpler if you want to, then transfer it to the `<PersistentDataPath>/Saves/v3/` folder for your server session.

Configure the server to load the transferred save with the `-saveName <name>` command line parameter. Specify the moved folder as the save name to use. Also make sure to set `GameSettingsPreset` to be empty, so it does not load some other preset instead of the settings you have copied. Make sure to not have a modified `ServerGameSettings.json` in the default settings folder (should not be modified, as mentioned above) or any override `ServerGameSettings.json` in the local override folder, to achieve the same end result of game settings as they were when hosted via the client.

Lastly, it is recommended to remove the files moved/copied to the server from their original client location, so the same save/session does not show up twice when you have played on the server save. You can remove the local save game via the in-game interface in the `Load Game` menu. When using Cloud Saves, it is important to do it from within the game (or when the game is running) otherwise the Cloud Sync feature will restore the files when you start the game the next time.

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

| Command | Parameters | Comment |
|------|:-------------:|:------|
| help | [command] | List all commands, or additional information about a specific command. |
| announce | &lt;message&gt; | Sends a message to all players connected to the server. |
| announcerestart | &lt;number&gt; | Sends a pre-configured message that announces server restart in x minutes to all players connected to the server. Less flexible than announce but has the benefit of being localized to each users language. |
| shutdown | &lt;message times&gt; &lt;message&gt; | Schedule shutdown of the server. |
| cancelshutdown | [message] | Cancel an active shutdown, with optional message. |
| name | &lt;name&gt; | Set/change the server name during runtime. |
| description | &lt;description&gt; | Set/change the server description during runtime. |
| password | [password] \| --clear | Set/change/clear the server password during runtime. |
| version | - | Show server version. |
| time | - | Show server time. |


To connect to the server you need an RCON client. There are multiple available, one known to work with V Rising is https://github.com/Tiiffi/mcrcon.
