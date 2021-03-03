--[[
    -- Jason1232 & KieranFYI
]]

--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("fpp", false, "an extension that allows you to use e2 to add people to you falcos prop protection buddies list and share individual items.")

--- sets the E2 Cost
__e2setcost(100)

--- Sets the version, remember to update this, else its useless
local version = "1.01"


local function Version()
    print(version)
end
concommand.Add("FPPE2_Version", Version)

local function FPPBuddyCheck(ply, otherPlayer, type)
    if not IsValid(ply) or not ply:IsPlayer() 
        or not IsValid(otherPlayer) or not otherPlayer:IsPlayer() then
        return false
    end

    if ply == otherPlayer then
        return true
    end

    if not otherPlayer.Buddies then
        return false
    end

    if not otherPlayer.Buddies[ply] then
        return false
    end

    if otherPlayer.Buddies[ply][type] then
        return otherPlayer.Buddies[ply][type]
    end

    return false
end

local function FPPChangeBuddy(ply, buddy, type, value)
    if not IsValid(ply) then return end

    ply.Buddies = ply.Buddies or {}

    if type == "Remove" then
        ply.Buddies[buddy] = nil
    else
        ply.Buddies[buddy] = ply.Buddies[buddy] or {Physgun = false, Gravgun = false, Toolgun = false, PlayerUse = false, EntityDamage = false}
        ply.Buddies[buddy][type] = value
    end

    local CPPIBuddies = {}
    for k, v in pairs(ply.Buddies) do if table.HasValue(v, true) then table.insert(CPPIBuddies, k) end end
    -- Also run at player spawn because clients send their buddies through this command
    hook.Run("CPPIFriendsChanged", ply, CPPIBuddies)

    -- Update the prop protection
    local affectedProps = {}
    for _, v in ipairs(ents.GetAll()) do
        local owner = v:CPPIGetOwner()
        if owner ~= ply then continue end
        table.insert(affectedProps, v)
    end

    FPP.recalculateCanTouch({buddy}, affectedProps)
    FPP.RecalculateConstrainedEntities({buddy}, affectedProps)
end

local function FPPShare(ply, ent, physgun, gravgun, toolgun, playeruse, entitydamage)
    if not IsValid(ply) or not ply:IsPlayer()
        or not IsValid(ent) then
        return
    end

    if ent:IsPlayer() then

        if physgun == 0 and gravgun == 0 and toolgun == 0 and playeruse == 0 and entitydamage == 0 then
            FPPChangeBuddy(ply, ent, "Remove", true)
        else

            if physgun ~= nil then
                FPPChangeBuddy(ply, ent, "Physgun", physgun >= 1 and true or false)
            end

            if gravgun ~= nil then
                FPPChangeBuddy(ply, ent, "Gravgun", gravgun >= 1 and true or false)
            end

            if toolgun ~= nil then
                FPPChangeBuddy(ply, ent, "Toolgun", toolgun >= 1 and true or false)
            end

            if playeruse ~= nil then
                FPPChangeBuddy(ply, ent, "Use", playeruse >= 1 and true or false)
            end

            if entitydamage ~= nil then
                FPPChangeBuddy(ply, ent, "Entity damage", entitydamage >= 1 and true or false)
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
        return FPPBuddyCheck(self.player, this, "Physgun") and 1 or 0
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
        return FPPBuddyCheck(self.player, this, "Gravgun") and 1 or 0
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
        return FPPBuddyCheck(self.player, this, "Toolgun") and 1 or 0
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
        return FPPBuddyCheck(self.player, this, "PlayerUse") and 1 or 0
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
        return FPPBuddyCheck(self.player, this, "EntityDamage") and 1 or 0
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
    
--- entity share	
e2function void entity:share(entity ply, number active)	
    if not IsValid(this) or not IsValid(ply) or not ply:IsPlayer() then	
        return nil	
    end

    local owner = self.player
    if this:CPPIGetOwner() ~= owner then	
        FPP.Notify(owner, "You do not have the right to share this entity.", false)	
        return	
    end

    local toggle = active >= 1	
    -- Make the table if it isn't there	
    if not this.AllowedPlayers and toggle then	
        this.AllowedPlayers = {ply}	
        FPP.Notify(ply, owner:Nick() .. " shared an entity with you!", true)	
    else	
        if toggle and not table.HasValue(this.AllowedPlayers, ply) then	
            table.insert(this.AllowedPlayers, ply)	
            FPP.Notify(ply, owner:Nick() .. " shared an entity with you!", true)	
        elseif not toggle then	
            for k, v in pairs(this.AllowedPlayers) do	
                if v == ply then	
                    table.remove(this.AllowedPlayers, k)	
                    FPP.Notify(ply, owner:Nick() .. " unshared an entity with you!", false)	
                end	
            end	
        end	
    end	

    FPP.recalculateCanTouch({ply}, {this})	
end
