local MAX_SPEED = 150        -- Normal max speed in MPH
local BYPASS_MAX_SPEED = 250 -- Max speed if bypass role is present
local BYPASS_ROLE = "speedbypass"

-- Convert MPH to meters per second
local function mphToMps(mph)
    return mph * 0.44704
end

-- Thread to check vehicle and apply speed limiter
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Check every 0.5 seconds
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local veh = GetVehiclePedIsIn(player, false)
            if GetPedInVehicleSeat(veh, -1) == player then
                -- Ask server if player has bypass role
                TriggerServerEvent("speedLimiter:checkBypass")
            end
        end
    end
end)

-- Event to apply speed limiter
RegisterNetEvent("speedLimiter:applyLimit")
AddEventHandler("speedLimiter:applyLimit", function(hasBypass)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh and veh ~= 0 then
        if hasBypass then
            SetEntityMaxSpeed(veh, mphToMps(BYPASS_MAX_SPEED))
        else
            SetEntityMaxSpeed(veh, mphToMps(MAX_SPEED))
        end
    end
end)
