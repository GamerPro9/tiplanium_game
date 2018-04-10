-----------------------------------------------------------
-- This mod remove the home and spawn privileges during a fight.
-- Thanks to Taikedz for cleaning the code--
-------------configuration---------------------------------

-- Other player cannot escape
-- false if the player being hit can't teleport when someone hits them.
local OPCE = false

-- How long in seconds until a battle ends (times since last hit)
local battletimeout = 15

-- Fight start message
local FightMessage = "You entered a Fight !"

-- Fight end message
local EndFightMessage = "The Fight is Over !"

---------------------------------------------

-- Get default privs at server level
local default_privs = minetest.setting_get("default_privs") or ""
default_privs = default_privs:split(",")

local dprivs = {}
for _,v in pairs(default_privs) do
	dprivs[v] = true
end

local playerinpvp = {}

local function limit_privs(playername)
	local privs = minetest.get_player_privs(playername)
	privs.home = nil
	privs.spawn = nil
	minetest.set_player_privs(playername, privs)
end

local function setplayerpvp(playername, isvictim)
	if isvictim and OPCE == true then return end

	if not playerinpvp[playername] then
		playerinpvp[playername] = 0
		minetest.chat_send_player(playername, FightMessage)
		limit_privs(playername)
	end
end

local function resettime(playername)
	if playerinpvp[playername] ~= nil then
		playerinpvp[playername] = 0
	end
end

local function restoreprivs(fighter)
	local privs = minetest.get_player_privs(fighter)
	privs.home = dprivs.home
	privs.spawn = dprivs.spawn

	minetest.set_player_privs(fighter, privs)

	playerinpvp[fighter] = nil
end

minetest.register_on_punchplayer(function(player, hitter)
	if not (player:is_player() and hitter:is_player() ) then
		return
	end
	
	local hittername = hitter:get_player_name()
	local victimname = player:get_player_name()

	setplayerpvp(hittername)
	setplayerpvp(victimname, true) -- moved OPCE check

	resettime(hittername)
	resettime(victimname) -- won't affect non-registered victims
end)

minetest.register_globalstep(function(dtime)
	for fighter,oldtime in pairs(playerinpvp) do
		local newtime = oldtime + dtime
		playerinpvp[fighter] = newtime
	
		if newtime >= battletimeout then
			restoreprivs(fighter)
			minetest.chat_send_player(fighter, EndFightMessage)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	restoreprivs( player:get_player_name() )
end)
