QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local owners = {}


QBCore.Functions.CreateCallback('carremote:checkOwnedVehicle', function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE citizenid = @citizenid AND plate = @plate', {['@citizenid'] = pData.PlayerData.citizenid, ['@plate'] = plate}, function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                if v.status ~= nil then
                    v.status = json.decode(v.status)
                end
            end
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(maxDistance, soundFile, maxVolume, vehicleNetId)
	TriggerClientEvent('carremote:playSoundFromVehicle', -1, source, maxDistance, soundFile, maxVolume, vehicleNetId)
end)

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('carremote:playSound', -1, source, maxDistance, soundFile, soundVolume)
end)