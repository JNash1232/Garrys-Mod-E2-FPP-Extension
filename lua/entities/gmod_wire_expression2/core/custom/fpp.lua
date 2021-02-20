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

local function FPPShare(ent, type, active)
    if not IsValid(ent) then
        return
    end
    
    if ent:CPPIGetOwner() ~= self.player then
        FPP.Notify(self.player, "You do not have the right to share this entity.", false)
        return
    end
    
    ent[type] = active
    FPP.recalculateCanTouch(player.GetAll(), {ent})
end

--[[ None of this works, because why add AllowedPlayers when you don't check it?	---- Just to piss you off? That to me sounds like the best reason.
--- physgun share
e2function void entity:share(entity target, number active)
    if not IsValid(this) or not IsValid(target) or not target:IsPlayer() then
        return nil
    end
    
    local ply = self.player

    if this:CPPIGetOwner() ~= ply then
        FPP.Notify(ply, "You do not have the right to share this entity.", false)
        return
    end

    local toggle = active >= 1
    -- Make the table if it isn't there
    if not this.AllowedPlayers and toggle then
        this.AllowedPlayers = {target}
        FPP.Notify(target, ply:Nick() .. " shared an entity with you!", true)
    else
        if toggle and not table.HasValue(this.AllowedPlayers, target) then
            table.insert(this.AllowedPlayers, target)
            FPP.Notify(target, ply:Nick() .. " shared an entity with you!", true)
        elseif not toggle then
            for k, v in pairs(this.AllowedPlayers) do
                if v == target then
                    table.remove(this.AllowedPlayers, k)
                    FPP.Notify(target, ply:Nick() .. " unshared an entity with you!", false)
                end
            end
        end
    end
    
    FPP.recalculateCanTouch({target}, {this})
end
--]]


--- physgun share
e2function void entity:sharePhysgun(number active)
    if not IsValid(this) then
        return nil
    end

    if this:IsPlayer() then
        FPP.SaveBuddy(this:SteamID(), "Physgun", "physgun", active >= 1 and 1 or 0)
    else 
        FPPShare(this, "SharePhysgun1", (active >= 1))
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
        FPPShare(this, "ShareGravgun1", (active >= 1))
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
        FPPShare(this, "ShareToolgun1", (active >= 1))
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
        FPPShare(this, "SharePlayerUse1", (active >= 1))
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
        FPPShare(this, "ShareEntityDamage1", (active >= 1))
    end
end

--- entity share all
e2function void entity:share(number active)
    if not IsValid(this) then
        return nil
    end
	this:sharePhysgun(active)
	this:shareGravgun(active)
	this:shareToolgun(active)
	this:shareUse(active)
	this:shareDamage(active)
end