--[[
    Lets see if this works
    -- Jason1232 & KieranFYI
]]


--- Include the fpp buddies library needed to actually add buddies
include("fpp/client/buddies.lua")

--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("fpp", false, "an extension that allows you to use e2 to add people to you falcos prop protection buddies list.")

--- physgun share
e2function void entity:sharePhysgun(number active)
    if not IsValid(this) then
		return nil
	end

	if this:IsPlayer() then
		FPP.SaveBuddy(this:SteamID(), "Physgun", "physgun", active >= 1 and 1 or 0)
	else 
		this.SharePhysgun1 = (active >= 1)
		FPP.recalculateCanTouch(player.GetAll(), {this})
	end
end


--- gravgun share
e2function void entity:shareGravgun(number active)
    if not IsValid(this) then
		return nil
	end
	
	if this:IsPlayer() then
		FPP.SaveBuddy(this:SteamID(), "Gravgun", "gravgun", active >= 1 and 1 or 0)
	else 
		this.ShareGravgun1 = (active >= 1)
		FPP.recalculateCanTouch(player.GetAll(), {this})
	end
end

--- toolgun share
e2function void entity:shareToolgun(number active)
    if not IsValid(this) then
		return nil
	end

	if this:IsPlayer() then
		FPP.SaveBuddy(this:SteamID(), "Toolgun", "toolgun", active >= 1 and 1 or 0)
	else 
		this.ShareToolgun1 = (active >= 1)
		FPP.recalculateCanTouch(player.GetAll(), {this})
	end
end

--- use share
e2function void entity:shareUse(number active)
    if not IsValid(this) then
		return nil
	end

	if this:IsPlayer() then
		FPP.SaveBuddy(this:SteamID(), "Use", "playeruse", active >= 1 and 1 or 0)
	else 
		this.SharePlayerUse1 = (active >= 1)
		FPP.recalculateCanTouch(player.GetAll(), {this})
	end
end

--- entity damage share
e2function void entity:shareDamage(number active)
    if not IsValid(this) then
		return nil
	end

	if this:IsPlayer() then
		FPP.SaveBuddy(this:SteamID(), "Entity damage", "entitydamage", active >= 1 and 1 or 0)
	else 
		this.ShareEntityDamage1 = (active >= 1)
		FPP.recalculateCanTouch(player.GetAll(), {this})
	end
end