local BYPASS_ROLE = "speedbypass"

RegisterServerEvent("speedLimiter:checkBypass")
AddEventHandler("speedLimiter:checkBypass", function()
    local src = source
    local hasBypass = IsPlayerAceAllowed(src, BYPASS_ROLE)
    -- Send true if the player has bypass, false otherwise
    TriggerClientEvent("speedLimiter:applyLimit", src, hasBypass)
end)
