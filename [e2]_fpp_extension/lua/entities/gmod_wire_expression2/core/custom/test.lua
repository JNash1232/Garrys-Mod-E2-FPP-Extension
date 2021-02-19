--[[
    Lets see if this works
    -- Jason1232
]]

E2Lib.RegisterExtension("fpp", false, "an extension that allows you to use e2 to add people to you falcos prop protection buddies list.")

e2function string ohCock()
    return "This is actually working, im a freaking genius."
end

--- this is a test to see if this works as a description
e2function string entity:physgunShare(number active)
    this.SharePhysgun1 = 1
    recalculateCanTouch(player.GetAll(), {this})
    return "testytest2"
end

e2function void entity:gravgunShare(number active)
    if not IsValid(this) and not this:IsPlayer() then return nil end
    this.ShareGravgun1 = (active == 1)
end

e2function void entity:useShare(number active)
    if not IsValid(this) and not this:IsPlayer() then return nil end
    this.SharePlayerUse1 = (active == 1)
end

e2function void entity:damageShare(number active)
    if not IsValid(this) and not this:IsPlayer() then return nil end
    this.ShareEntityDamage1 = (active == 1)
end

e2function void entity:toolgunShare(number active)
    if not IsValid(this) and not this:IsPlayer() then return nil end
    this.ShareToolgun1 = (active == 1)
end