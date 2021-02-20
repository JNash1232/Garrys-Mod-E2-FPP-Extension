--[[
    Lets see if this works
    -- Jason1232 & KieranFYI
]]


--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("propbasic", false, "a basic alternative to propcore")

--- sets the cost
__e2setcost(50)


--- propfreeze, 1 = frozen, 0 = unfrozen, pretty much same as propcore
e2function void entity:propFreeze(number frozen)
    if not IsValid(this) or this:IsPlayer() then
        return nil
    end

    this:GetPhysicsObject():EnableMotion(frozen <= 0)
end

--- propsolid sets the solidity of the prop 
e2function void entity:propNotSolid(number solid)
    if not IsValid(this) or this:IsPlayer() then
        return nil
    end
    
    this:SetSolid(solid >= 1 and 6 or 0)
end

--- gets the solidity of the prop
e2function number entity:propIsSolid()
    if not IsValid(this) or this:IsPlayer() then
        return nil
    end
    
    local solid = this:GetSolid() and 1 or 0
    return solid
end

