

if Musketeer_Ammo_Skills == nil then
	Musketeer_Ammo_Skills = { test = 0 }
end

PersistentVars  = {
	HandshakeCompleted = false,
	SkillListLoaded = false,
	HotbarUIInputFocusActive = false,
	PlayerCharacterGUID = "",
	PlayerActiveSkillPreview = false,
	CurrentHotbar = 1,
}

function InitPlayerState()
	-- Persistent variables are only available after SessionLoaded is triggered!
	PersistentVars["HandshakeCompleted"] = false
	PersistentVars["SkillListLoaded"] = false
	PersistentVars["HotbarUIInputFocusActive"] = false
	PersistentVars["PlayerCharacterGUID"] = ""
	PersistentVars["PlayerActiveSkillPreview"] = false
	PersistentVars["CurrentHotbar"] = 1
    --Ext.Print("InitPlayerState. Handshake is: " .. PersistentVars["HandshakeCompleted"])
end
Ext.RegisterListener("SessionLoaded", InitPlayerState)


function PrintPlayerState()
	Ext.Print("PlayerState Info:")
	Ext.Print(PersistentVars["HandshakeCompleted"])
	Ext.Print(PersistentVars["SkillListLoaded"])
	Ext.Print(PersistentVars["HotbarUIInputFocusActive"])
	Ext.Print(PersistentVars["PlayerCharacterGUID"])
	Ext.Print(PersistentVars["PlayerActiveSkillPreview"])
	Ext.Print(PersistentVars["CurrentHotbar"])
end

function PrintSkillList()
	Ext.Print("SkillList Info:")
	Ext.Print(Musketeer_Ammo_Skills)
	Ext.Print(Musketeer_Ammo_Skills["test"])
	Ext.Print(Musketeer_Ammo_Skills["Shout_Reload"])
	Ext.Print(Musketeer_Ammo_Skills["Target_Unload_Test"])
end



-- Try out positioning by setting x and y directly, as in:
-- x = 200, y = 110 in MainTimeLine.
-- For some reason, doing that by means of ui:SetValue("x", 200) makes the UI position
-- always be the same relative to the other Ui elements.
local function Musketeer_AmmoBar_Init()
    print("Musketeer_Open_TestWindow called.")
	local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf",3)
		ui:Hide()
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		--Ext.RegisterUICall(ui, "onEvent", LeaderLib_Debug_OnDebugUIEvent)
		print("[Musketeer:BootstrapClient.lua] Hiding ammo window.")
		ui:Hide()
		ui:Invoke("setAmmoCount", 11)
		--ui:SetPosition(200,70)
	end
	print("AmmoBar Initialized.")
end


-- Currently 5 AmmoTypes are implemented:
-- 0: default
-- 1: fire
-- 2: ice
-- 3: shock
-- 4: doom
-- 5: explode
local function Musketeer_AmmoBar_ElementChange(call, value)
	--if value < 0 or value > 5 then
	--	value = 0
	--end
    print("Musketeer_AmmoBar_ElementChange called.")
    local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		--Ext.RegisterUICall(ui, "onEvent", LeaderLib_Debug_OnDebugUIEvent)
		ui:Invoke("forceAmmoBarReset")
		ui:Invoke("setAmmoElement", value)
	end
	print("AmmoBar Element changed.")
end

-- Preview Ammo Restoration/Ammo Consumption
-- negative value -> consume preview
-- positive value -> restore preview
local function Musketeer_AmmoBar_Difference_Preview(call, value)
	print("Musketeer_AmmoBar_Difference_Preview entry")
	print("value: " .. value)
	if value ~= nil and type(value) == string then
		print("Musketeer_AmmoBar_Difference_Preview converted string to number")
		value = tonumber(value)
	end
    print("Musketeer_AmmoBar_Difference_Preview called.")
    local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil and value ~= 0 then
		print("Should be previewing now...")
		ui:Invoke("forceAmmoBarReset")
		if value < 0 then
			ui:Invoke("previewAmmoConsumption", (0 - value))
		else
			ui:Invoke("previewAmmoGain", value)
		end
	end
	print("Preview Ammo Difference.")
end


local function Musketeer_AmmoBar_SetAmmo(call, value)
    print("Musketeer_AmmoBar_SetAmmo called.")
    local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		--Ext.RegisterUICall(ui, "onEvent", LeaderLib_Debug_OnDebugUIEvent)
		ui:Invoke("forceAmmoBarReset")
		ui:Invoke("setAmmoCount", value)
	end
	print("Set Ammo Count.")
end

local function Musketeer_AmmoBar_SetMaxAmmo(call, value)
    print("Musketeer_AmmoBar_SetMaxAmmo called.")
    local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		--Ext.RegisterUICall(ui, "onEvent", LeaderLib_Debug_OnDebugUIEvent)
		ui:Invoke("forceAmmoBarReset")
		ui:Invoke("setMaxAmmoCount", value)
	end
	print("Set Max Ammo Count.")
end


local function Musketeer_AmmoBar_Visibility(call, value)
	print(call)
	print(value)
	print(type(value))
	--if value ~= nil and type(value) == string then
	--	value = tonumber(value)
	--end
    print("Musketeer_AmmoBar_Visibility called.")
    local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		--Ext.RegisterUICall(ui, "onEvent", LeaderLib_Debug_OnDebugUIEvent)
		ui:Invoke("forceAmmoBarReset")
		if value == "0" then
			ui:Hide()
		elseif value == "1" then
			ui:Show()
		else
			print("Invalid Value, value should be a Boolean (0 or 1)")
		end
	end
	print("AmmoBar visibility set")
end



--- @param force boolean Optional parameter to force a reset, even when the active skill preview is on.
local function Musketeer_Reset_Previews_AmmoBar(force)
	force = force or false
	if PersistentVars["PlayerActiveSkillPreview"] == false and force == false then
		print("Musketeer_Reset_AmmoBar called.")
		local ui = Ext.GetUI("AmmoBarGUIv1.swf")
		if ui == nil then
			ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
			print("ui was nil, thus looking with relative path.")
		end
		if ui ~= nil then
			ui:Invoke("forceAmmoBarReset")
		end
		print("AmmoBar reset.")
	end
end

local function Musketeer_AmmoBar_BreathingMode(call, value)
    print("Musketeer_AmmoBar_BreathingMode called.")
	local ui = Ext.GetUI("AmmoBarGUIv1.swf")
	if ui == nil then
		ui = Ext.CreateUI("AmmoBarGUIv1.swf", "Public/Musketeer_414af60f-550c-4134-a560-ae3f69f2dc52/GUI/AmmoBarGUIv1.swf", 2)
		print("ui was nil, thus looking with relative path.")
	end
	if ui ~= nil then
		ui:Invoke("setAmmoPrevBreathingMode", value)
	end
	print("AmmoBar BreathindMode set.")
end




local function Musketeer_Ammo_Skills_Add(name, val)
	Musketeer_Ammo_Skills[name] = val
	print(Musketeer_Ammo_Skills)
	print("Musketeer_Ammo_Skills added entry: ".. name .. " val: ".. val)
	PersistentVars["SkillListLoaded"] = true
end


local function Musketeer_Receive_Rifle_Skill(call, payload)
	--print("[Client] Musketeer_Receive_Rifle_Skill called")
	local decoded = Ext.JsonParse(payload)
	if decoded["skillname"] == "Shout_Reload" then
		--print("[CLIENT] Client received Shout_Reload and should add it to the Skilllist.")
		decoded["ammocost"] = 11;
	end
	if decoded["skillname"] == "Target_Unload_Test" then
		decoded["ammocost"] = -11;
	end
	Musketeer_Ammo_Skills_Add(decoded["skillname"], decoded["ammocost"])
	--print(Musketeer_Ammo_Skills)
end




-- Currently, this doesnt check "Shout_Reload" for some reason.
local function skillCheckForAmmoBarPreview(skill, character, isFromItem, param)
	print(skill["Name"])
	local skillName = skill["Name"]

	local amount = Musketeer_Ammo_Skills[skillName]
	print(amount)

	if amount ~= nil and type(amount) == string then
		amount = tonumber(amount)
		print("converted number from string to number")
	end
	if amount ~= nil and amount ~= 0 then
		print("skillCheckForAmmoBarPreview was called. Deprecated, thus no action.")
		--print("skillCheckForAmmoBarPreview check here, skill is present and doesn't cost 0");
		--Musketeer_AmmoBar_Difference_Preview(nil, amount)
	end
	print("End of skillCheckForAmmoBarPreview")
end
Ext.RegisterListener("SkillGetDescriptionParam", skillCheckForAmmoBarPreview)


local function BuiltInHotbarUIHideToolbar()
	print("Hotbar Hide Tooltip event fired.")
	if PersistentVars["HotbarUIInputFocusActive"] == false then
		Musketeer_Reset_Previews_AmmoBar()
	end
end

local function BuiltInHotbarUIShowTooltip(ui, call, arg1, arg2)
	print("Hotbar Show Tooltip event fired.")
	if arg1 ~= nil then
		print(arg1)
	else
		print("[BuiltInHotbarUIShowTooltip]: arg1 was nil.")
	end
	if arg2 ~= nil then
		print(arg2)
	else
		print("[BuiltInHotbarUIShowTooltip]: arg2 was nil.")
	end
	Musketeer_Reset_Previews_AmmoBar()
end

local function BuiltInHotbarUIStartDragging(ui, call, arg1)
	print("Hotbar Start Dragging event fired.")
	print(arg1)
	--Musketeer_Reset_Previews_AmmoBar()
end

local function BuiltInHotbarUIShowSkillTooltip(ui, call, handler, skillname)
	print("Hotbar Show Skill Tooltip event fired.")
	--print(arg1)
	--print(arg2)
	print(skillname)
	local skillName = skillname

	local amount = Musketeer_Ammo_Skills[skillName]
	print(amount)

	if amount ~= nil and type(amount) == string then
		amount = tonumber(amount)
		print("converted number from string to number")
	end
    if amount ~= nil and amount ~= 0 then
		print("skillCheckForAmmoBarPreview check here, skill is present and doesn't cost 0");
		Musketeer_AmmoBar_Difference_Preview(nil, amount)
	else
		Musketeer_Reset_Previews_AmmoBar()
	end
	print("End of BuiltInHotbarUIShowSkillTooltip")
end

local function BuiltInHotbarUIShowItemTooltip(ui, call, handler, skillname)
	print("Hotbar Show Item Tooltip event fired.")
	print(handler)
	print(skillname)
	PersistentVars["HotbarUIInputFocusActive"] = false
	Musketeer_Reset_Previews_AmmoBar()
end

local function BuiltInHotbarUIInputFocus(ui, call, arg1)
	print("Hotbar Focus Input event fired.")
	print(arg1)
	PersistentVars["HotbarUIInputFocusActive"] = true
	--Musketeer_Reset_Previews_AmmoBar()
end

local function BuiltInHotbarUIInputFocusLost(ui, call, arg1)
	print("Hotbar Focus Input Lost event fired.")
	print(arg1)
	PersistentVars["HotbarUIInputFocusActive"] = false
	Musketeer_Reset_Previews_AmmoBar()
end

local function BuiltInHotbarUISelectSlot(ui, call, arg1)
	print("Hotbar Slot Selected event fired.")
	print(arg1)
end

local function BuiltInHotbarUIUseAction(ui, call, arg1)
	print("Hotbar Use Action Event fired.")
	print(arg1)
end

local function BuiltInHotbarUISlotUpEnd(ui, call, arg1)
	print("----------------------------------")
	print("Hotbar UI Slot Up End Event fired.")
	print(arg1)
end

local function BuiltInHotbarUIButtonPressed(ui, call, arg1)
	print("----------------------------------")
	print("Hotbar UI Button Pressed Event fired.")
	print(arg1)
end

local function BuiltInHotbarUISlotPressed(ui, call, arg1, arg2)
	print("----------------------------------")
	print("Hotbar UI Slot Pressed Event fired.")
	print(arg1)
	print(arg2)
end

-- We will need to send a json string over because we need to pass 2 variables;
-- player and slotNumber.
local function RequestServerSkillbarEntry(index)
	local skillbarRequest = {}
	skillbarRequest["player"] = PersistentVars["PlayerCharacterGUID"]
	skillbarRequest["slotnumber"] = index
	local jsonSkillbarRequest = Ext.JsonStringify(skillbarRequest)
	Ext.PostMessageToServer('skillbar_entry_request', jsonSkillbarRequest)
end

local function ReceiveSkillbarEntry(call, entry)
	print("[Client]: Got SkillbarEntry from Server, preview...")
	if PersistentVars["PlayerActiveSkillPreview"] == true then
		BuiltInHotbarUIShowSkillTooltip(nil, nil, nil, entry)
	end
end
Ext.RegisterNetListener("skillbar_entry_answer", ReceiveSkillbarEntry)

local function BuiltInHotbarActiveSkill(ui, call, arg1, index)
	print("----------------------------------")
	print("Hotbar UI Active Skill Preview.")
	-- NOTE: if index >= 1.0, then activeskil preview is on, else its off.
	print(arg1)
	print(index)
	print("===================================")
	if arg1 >= 0 then
		local hotbarUI = Ext.GetBuiltinUI("Public/Game/GUI/hotBar.swf")
		print(hotbarUI)

		arg1 = arg1 + (PersistentVars["CurrentHotbar"]-1) * 29
		print("Multiplied Skillbar Slot index with current Skillbar index.")
		print(arg1)

		PersistentVars["PlayerActiveSkillPreview"] = true
		RequestServerSkillbarEntry(arg1)
	elseif arg1 < 0 then
		PersistentVars["PlayerActiveSkillPreview"] = false
		Musketeer_Reset_Previews_AmmoBar()
	end
end


-- TODO

--[[
PersistentVars / AmmoPreview
-----
Consider adding a collection of vars that describe a players state.
Things to contain:
bool:Player Rifle Skill-List is loaded from server
bool:Player is previewing ammo cost -> 
	HideTooltip doesn't disable AmmoPreview when UIInputFocus is active (UIInputFocus called)
[23/05] Implemented such a state, but thinking i can't achieve the effect i want with the currently registered UI events.
-----
Synchronization
-----
Add something akin to a handshake ping-pong between client and server to check
for state. -> Primarily to replace manual "Ext.PostMessageToServer('clientReady', 1)" calls.

Maybe something like state polling, similiar to how WebRTC handles Signaler Polling?
-----
MaxAmmo UI Display
-----
Add preview of maximum Ammo on UI, by showing ammo counters with low opacity.
This would probably be best done purely in AS.
-----
AmmoBar Positioning
-----
Look into hotbar code to see how proper screen positioning is implemented.
-----

--]]

local function SetCurrentHotbar(ui, event, index)
	print("Current Hotbar switched")
	print(index)
	PersistentVars["CurrentHotbar"] = index
end

-- Signal that client is ready for rifle skill broadcast
local function Musketeer_Client_Signal_Ready()
	print("Client is ready.")
	Ext.PostMessageToServer('clientReady', 1)
end

local function RegisterBuiltInUIListeners() 
	-- Listen to the hotbar for when the sheet opens
	local hotbar = Ext.GetBuiltinUI("Public/Game/GUI/hotBar.swf")
	if hotbar ~= nil then
		Ext.RegisterUICall(hotbar, "hideTooltip", BuiltInHotbarUIHideToolbar)
		Ext.RegisterUICall(hotbar, "showTooltip", BuiltInHotbarUIShowTooltip)
		Ext.RegisterUICall(hotbar, "startDragging", BuiltInHotbarUIStartDragging)
		Ext.RegisterUICall(hotbar, "showSkillTooltip", BuiltInHotbarUIShowSkillTooltip)
		Ext.RegisterUICall(hotbar, "showItemTooltip", BuiltInHotbarUIShowItemTooltip)
		Ext.RegisterUICall(hotbar, "inputFocus", BuiltInHotbarUIInputFocus)
		Ext.RegisterUICall(hotbar, "inputFocusLost", BuiltInHotbarUIInputFocusLost)
		Ext.RegisterUICall(hotbar, "IE UISelectSlot", BuiltInHotbarUISelectSlot)
		Ext.RegisterUICall(hotbar, "useAction", BuiltInHotbarUIUseAction)
		Ext.RegisterUICall(hotbar, "slotUpEnd", BuiltInHotbarUISlotUpEnd)
		Ext.RegisterUICall(hotbar, "hotbarBtnPressed", BuiltInHotbarUIButtonPressed)
		Ext.RegisterUICall(hotbar, "SlotPressed", BuiltInHotbarUISlotPressed, "IsOnCooldown")
		
		Ext.RegisterUIInvokeListener(hotbar, "setCurrentHotbar", SetCurrentHotbar)

		
		Ext.RegisterUIInvokeListener(hotbar, "showActiveSkill", BuiltInHotbarActiveSkill)
		--Ext.RegisterUICall(hotbar, "PlaySound", BuiltInHotbarUIPlaySound)
		print("[Musketeer:RegisterBuiltInUIListeners] Found (hotBar.swf). Registered listeners.")
	else
		print("[Musketeer:RegisterBuiltInUIListeners] Failed to find Public/Game/GUI/hotBar.swf")
	end
end
Ext.RegisterListener("SessionLoaded", RegisterBuiltInUIListeners)


--- Registers a listener that is called when a network message is received on the specified channel
--- @param channel string Network channel name
--- @param handler function Lua handler
Ext.RegisterNetListener("Musketeer_SetAmmo_AmmoBar_UI", Musketeer_AmmoBar_SetAmmo)
Ext.RegisterNetListener("Musketeer_SetMaxAmmo_AmmoBar_UI", Musketeer_AmmoBar_SetMaxAmmo)
Ext.RegisterNetListener("Musketeer_Preview_AmmoBar_UI", Musketeer_AmmoBar_Difference_Preview)
Ext.RegisterNetListener("Musketeer_Element_AmmoBar_UI", Musketeer_AmmoBar_ElementChange)
Ext.RegisterNetListener("Musketeer_Set_AmmoBar_UI", Musketeer_AmmoBar_Visibility)
Ext.RegisterNetListener("Musketeer_Init_AmmoBar_UI", Musketeer_AmmoBar_Init)
Ext.RegisterNetListener("Musketeer_Reset_AmmoBar_UI", Musketeer_Reset_Previews_AmmoBar)
Ext.RegisterNetListener("Musketeer_AmmoBar_BreathingMode", Musketeer_AmmoBar_BreathingMode)
Ext.RegisterNetListener("Musketeer_Rifle_Skill", Musketeer_Receive_Rifle_Skill)

--Ext.RegisterListener("StatsLoaded", Musketeer_Client_Signal_Ready)
--Ext.RegisterListener("ModuleResume", Musketeer_Client_Signal_Ready)



local function ReceiveServerOffer(call, player, arg1)
	Ext.PostMessageToServer('clientAck', player)
	PersistentVars["HandshakeCompleted"] = true
	-- Not a clean solution, but didn't find out how else to get char GUID from a player locally.
	-- This probably doesn't persist switching out character from your team.
	PersistentVars["PlayerCharacterGUID"] = player
	print("[Client] Player: " .. player .. " got Server message.")
	--print("[Client] Debugstuff:")
	--print(call)
	--print(handler)
	--print(player)
end
Ext.RegisterNetListener("Musketeer_SendHello", ReceiveServerOffer)


local function ReceiveServerRequest(channel, player)
	print("[CLIENT] Received ServerRequest and I am: " .. player)
	PersistentVars["PlayerCharacterGUID"] = player
	PersistentVars["HandshakeCompleted"] = true
	Ext.PostMessageToServer('clientReady', player)
	Musketeer_AmmoBar_Init();
end
Ext.RegisterNetListener("requestClient", ReceiveServerRequest)