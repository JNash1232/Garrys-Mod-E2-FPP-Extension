--[[
    Lets see if this works
    -- Jason1232 & KieranFYI
]]


--- Include the fpp buddies library needed to actually add buddies
include("fpp/client/buddies.lua")

--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("fpp", false, "an extension that allows you to use e2 to add people to you falcos prop protection buddies list and share individual items.")

--- sets the E2 Cost
__e2setcost(100)

local function FPPShare(ply, ent, physgun, gravgun, toolgun, playeruse, entitydamage)
    if not IsValid(ent) then
        return
    end

	if ent:IsPlayer() then

		if physgun == 0 and gravgun == 0 and toolgun == 0 and playeruse == 0 and entitydamage == 0 then
			FPP.SaveBuddy(ent:SteamID(), "Remove", "remove")
		else
			if physgun ~= nil then
				FPP.SaveBuddy(ent:SteamID(), "Physgun", "physgun", physgun >= 1 and 1 or 0)
			end

			if gravgun ~= nil then
				FPP.SaveBuddy(ent:SteamID(), "Gravgun", "gravgun", gravgun >= 1 and 1 or 0)
			end

			if toolgun ~= nil then
				FPP.SaveBuddy(ent:SteamID(), "Toolgun", "toolgun", toolgun >= 1 and 1 or 0)
			end

			if playeruse ~= nil then
				FPP.SaveBuddy(ent:SteamID(), "Use", "playeruse", playeruse >= 1 and 1 or 0)
			end
			
			if entitydamage ~= nil then
				FPP.SaveBuddy(ent:SteamID(), "Entity damage", "entitydamage", entitydamage >= 1 and 1 or 0)
			end
		end
	else
    
		if ent:CPPIGetOwner() ~= ply then
			FPP.Notify(ply, "You do not have the right to share this entity.", false)
			return
		end
		
		if physgun ~= nil then
        	ent["SharePhysgun1"] = (physgun >= 1)
		end

		if gravgun ~= nil then
			ent["ShareGravgun1"] = (gravgun >= 1)
		end

		if toolgun ~= nil then
			ent["ShareToolgun1"] = (toolgun >= 1)
		end
		
		if playeruse ~= nil then
			ent["SharePlayerUse1"] = (playeruse >= 1)
		end
		
		if entitydamage ~= nil then
			ent["ShareEntityDamage1"] = (entitydamage >= 1)
		end		

		FPP.recalculateCanTouch(player.GetAll(), {ent})
	end
end

local function FPPBuddyCheck(ply, otherPlayer, type)
    if not IsValid(ply) or not ply:IsPlayer() 
		or not IsValid(otherPlayer) or not otherPlayer:IsPlayer()then
        return false
    end

	if ply == otherPlayer then
		return true
	end

	if not otherPlayer.Buddies then
		return false
	end
	
	local steamID = ply:SteamID()
	if not table.HasValue(otherPlayer.Buddies, steamID) then
		return false
	end

    if table.HasValue(otherPlayer.buddies[steamId], type) then
		return otherPlayer.buddies[steamId][type]
	end
	
	return false
end

--- physgun share
e2function void entity:sharePhysgun(number active)
    if not IsValid(this) then
        return nil
    end

    FPPShare(self.player, this, active, nil, nil, nil, nil)
end

--- physgun check
e2function number entity:canPhysgun()
    if not IsValid(this) then
        return 0
    end

	
    if this:IsPlayer() then
		return FPPBuddyCheck(self.player, this, "physgun") and 1 or 0
	else
		return this:CPPICanPhysgun(self.player) and 1 or 0
	end
end


--- gravgun share
e2function void entity:shareGravgun(number active)
    if not IsValid(this) then
        return nil
    end
    
	FPPShare(self.player, this, nil, active, nil, nil, nil)
end

--- gravgun check
e2function number entity:canGravgun()
    if not IsValid(this) then
        return 0
    end

	
    if this:IsPlayer() then
		return FPPBuddyCheck(self.player, this, "gravgun") and 1 or 0
	else
		return this:CPPICanGravgun(self.player) and 1 or 0
	end
end

--- toolgun share
e2function void entity:shareToolgun(number active)
    if not IsValid(this) then
        return nil
    end

	FPPShare(self.player, this, nil, nil, active, nil, nil)
end

--- toolgun check
e2function number entity:canToolgun()
    if not IsValid(this) then
        return 0
    end

	
    if this:IsPlayer() then
		return FPPBuddyCheck(self.player, this, "toolgun") and 1 or 0
	else
		return this:CPPICanTool(self.player, "toolgun") and 1 or 0
	end
end

--- use share
e2function void entity:shareUse(number active)
    if not IsValid(this) then
        return nil
    end
    
	FPPShare(self.player, this, nil, nil, nil, active, nil)
end

--- use check
e2function number entity:canUse()
    if not IsValid(this) then
        return 0
    end

	
    if this:IsPlayer() then
		return FPPBuddyCheck(self.player, this, "playeruse") and 1 or 0
	else
		return this:CPPICanUse(self.player) and 1 or 0
	end
end

--- entity damage share
e2function void entity:shareDamage(number active)
    if not IsValid(this) then
        return nil
    end

	FPPShare(self.player, this, nil, nil, nil, nil, active)
end

--- use check
e2function number entity:canDamage()
    if not IsValid(this) then
        return 0
    end

	
    if this:IsPlayer() then
		return FPPBuddyCheck(self.player, this, "entitydamage") and 1 or 0
	else
		return this:CPPICanDamage(self.player) and 1 or 0
	end
end

--- entity share all
e2function void entity:share(number active)
    if not IsValid(this) then
        return nil
    end

	FPPShare(self.player, this, active, active, active, active, active)
end