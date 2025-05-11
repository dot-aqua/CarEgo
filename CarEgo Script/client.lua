-- Event triggered when the player enters a vehicle
CreateThread(function()
    while true do
        Wait(0) -- Prevent freezing the game
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            SetFollowVehicleCamViewMode(4) -- Force first-person view
        end
    end
end)

local allowedVehicles = {}
local enableParkingSensor = true

-- Load the config from the second _resource.lua
CreateThread(function()
    if type(allowedVehiclesConfig) == "table" then
        if allowedVehiclesConfig.vehicles then
            allowedVehicles = allowedVehiclesConfig.vehicles
            print("Config loaded successfully from _resource.lua. Allowed vehicles:")
            for _, vehicle in ipairs(allowedVehicles) do
                print(string.format("Model: %s, Offset: %.2f", vehicle.model, vehicle.offset or 0.5))
            end
        end
        if allowedVehiclesConfig.enableParkingSensor ~= nil then
            enableParkingSensor = allowedVehiclesConfig.enableParkingSensor
            print("Parking sensor enabled:", enableParkingSensor)
        end
    else
        print("Error: Could not load config from _resource.lua. Ensure the format is correct.")
    end
end)

local function getVehicleConfig(vehicle)
    local model = GetEntityModel(vehicle)
    for _, vehicleConfig in ipairs(allowedVehicles) do
        if model == GetHashKey(vehicleConfig.model) then -- Ensure comparison uses hash keys
            return vehicleConfig
        end
    end
    return nil
end

local function setRearViewCamera(vehicle)
    local vehicleConfig = getVehicleConfig(vehicle)
    if not vehicleConfig then return nil end -- Ensure the vehicle is in the config

    local minDim, maxDim = GetModelDimensions(GetEntityModel(vehicle)) -- Get vehicle dimensions
    local rearOffsetZ = minDim.z + 0.3 -- Set height near the tires
    local rearOffsetY = maxDim.y + (vehicleConfig.offset or 0.5) -- Use offset from config

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    AttachCamToEntity(cam, vehicle, 0.0, -rearOffsetY, rearOffsetZ, true) -- Attach camera dynamically based on dimensions
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)

    -- Apply the helicopter camera effect
    SetTimecycleModifier("heliGunCam") -- Helicopter gun camera effect

    -- Show the reverse camera overlay
    SendNUIMessage({ action = "showOverlay", distance = "Calculating..." })

    -- Continuously update the camera rotation and distance sensor
    if enableParkingSensor then
        CreateThread(function()
            local lastBeepTime = 0
            while DoesCamExist(cam) do
                local vehicleHeading = GetEntityHeading(vehicle)
                SetCamRot(cam, 0.0, 0.0, vehicleHeading + 180.0, 2) -- Rotate camera to look backward

                -- Calculate distance to the nearest object, including objects with physics
                local rearCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -rearOffsetY - 1.0, rearOffsetZ)
                local rayHandle = StartShapeTestCapsule(rearCoords.x, rearCoords.y, rearCoords.z, rearCoords.x, rearCoords.y - 5.0, rearCoords.z, 1.0, 10, vehicle, 7)
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                local distance = hit and #(rearCoords - endCoords) or "N/A"

                -- Check if the hit entity has physics
                if entityHit and DoesEntityExist(entityHit) and IsEntityAnObject(entityHit) then
                    if not IsEntityStatic(entityHit) then
                        -- Object with physics detected
                        distance = #(rearCoords - endCoords)
                    end
                end

                -- Update the UI with the distance
                SendNUIMessage({ action = "updateDistance", distance = type(distance) == "number" and string.format("%.2f m", distance) or "N/A" })

                -- Play beeping sound based on distance
                if type(distance) == "number" and distance <= 5.0 then
                    local beepInterval = math.max(100, distance * 200) -- Closer = faster beeping
                    local currentTime = GetGameTimer()
                    if currentTime - lastBeepTime >= beepInterval then
                        PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true) -- Beep sound
                        lastBeepTime = currentTime
                    end
                end

                Wait(100) -- Update every 100ms
            end
        end)
    end

    return cam
end

local function resetCamera()
    RenderScriptCams(false, false, 0, true, true)
    DestroyAllCams(true)
    ClearTimecycleModifier() -- Remove the camera filter

    -- Hide the reverse camera overlay
    SendNUIMessage({ action = "hideOverlay" })
end

CreateThread(function()
    local rearCam = nil
    while true do
        Wait(0) -- Prevent freezing the game
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if IsPedInAnyVehicle(playerPed, false) then
            local vehicleConfig = getVehicleConfig(vehicle)
            if vehicleConfig then -- Only proceed if the vehicle is in the config
                SetFollowVehicleCamViewMode(4) -- Force first-person view

                if IsControlJustPressed(0, 26) then -- 'C' key
                    if rearCam == nil then
                        rearCam = setRearViewCamera(vehicle)
                    end
                elseif IsControlJustReleased(0, 26) then -- Release 'C' key
                    if rearCam ~= nil then
                        resetCamera()
                        rearCam = nil
                    end
                end
            else
                if rearCam ~= nil then
                    resetCamera()
                    rearCam = nil
                end
            end
        else
            if rearCam ~= nil then
                resetCamera()
                rearCam = nil
            end
        end
    end
end)
