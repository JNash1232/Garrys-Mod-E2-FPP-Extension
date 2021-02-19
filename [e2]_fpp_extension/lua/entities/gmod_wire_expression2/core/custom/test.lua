--[[
    Lets see if this works
    -- Jason1232 & KieranFYI
]]


--- Include the fpp buddies library needed to actually add buddies
include("fpp/client/buddies.lua")

--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("fpp", false, "an extension that allows you to use e2 to add people to you falcos prop protection buddies list.")

--- physgun share
e2function void entity:physgunShare(number active)
    if not IsValid(this) or not this:IsPlayer() then return nil end
    FPP.SaveBuddy(this:SteamID(), "Physgun", "physgun", active)
end

--- gravgun share
e2function void entity:gravgunShare(number active)
    if not IsValid(this) or not this:IsPlayer() then return nil end
    FPP.SaveBuddy(this:SteamID(), "Gravgun", "gravgun", active)
end

--- use share
e2function void entity:useShare(number active)
    if not IsValid(this) or not this:IsPlayer() then return nil end
    FPP.SaveBuddy(this:SteamID(), "Use", "playeruse", active)
end

--- entity damage share
e2function void entity:damageShare(number active)
    if not IsValid(this) or not this:IsPlayer() then return nil end
    FPP.SaveBuddy(this:SteamID(), "Entity damage", "entitydamage", active)
end

--- toolgun share
e2function void entity:toolgunShare(number active)
    if not IsValid(this) or not this:IsPlayer() then return nil end
    FPP.SaveBuddy(this:SteamID(), "Toolgun", "toolgun", active)
end