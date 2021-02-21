--[[
    -- Jason1232 & KieranFYI
]]

--- Register this extension, give it a name and desc and disabled by default
E2Lib.RegisterExtension("propbasic", false, "a basic alternative to propcore")

--- sets the cost
__e2setcost(50)

--- propfreeze, 1 = frozen, 0 = unfrozen, pretty much same as propcore
e2function void entity:propFreeze(number frozen)
	if not IsValid(this) or this:IsPlayer() 
		or not this:CPPICanPhysgun(self.player) then
		return nil
    end

	local phys = this:GetPhysicsObject()
	phys:EnableMotion(frozen <= 0)
	phys:Wake()
end

--- sets gravity
e2function void entity:enableGravity(number active)
	if not IsValid(this) or this:IsPlayer() 
		or not this:CPPICanTool(self.player, "toolgun") then
		return nil
	end

	local phys = this:GetPhysicsObject()
	phys:EnableGravity(active >= 1)
	phys:Wake()
end

--- enableDrag ... it enables/disbales drag
e2function void entity:enableDrag(number active)
    if not IsValid(this) or this:IsPlayer() 
		or not this:CPPICanTool(self.player, "toolgun") then
		return nil
	end

	local phys = this:GetPhysicsObject()
	phys:EnableDrag(active >= 1)
	phys:Wake()
end

--- propsolid sets the solidity of the prop 
e2function void entity:propNotSolid(number solid)
	if not IsValid(this) or this:IsPlayer() 
		or not this:CPPICanTool(self.player, "toolgun") then
		return nil
	end

    this:SetSolid(solid >= 1 and 0 or 6)
end

--- drawShadow sets if E should draw shadows
e2function void entity:drawShadow(number draw)
    if not IsValid(this) or this:IsPlayer() 
		or not this:CPPICanTool(self.player, "toolgun") then
		return nil
	end

    this:DrawShadow(draw >= 1)
end