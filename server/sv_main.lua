ESX = nil

local webhook = ""

local ValmistusTarpeet = {
    {
        label = "Beretta 92FS",
        itemi = "weapon_pistol",
        tarpeet = {
            {item = "tiirikka", maara = 1}
        },
        ase = true,
    }
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('civikki_kasaus:Kasaus')
AddEventHandler('civikki_kasaus:Kasaus', function(label, itemi, tarpeet, ase)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)
    local on = 0
    for i = 1, #tarpeet do
        Wait(5)
		if xPlayer.getInventoryItem(tarpeet[i].item).count >= tarpeet[i].maara then
            on = on + 1
        end
    end
    Wait(1000)
    if on == #tarpeet then
        for i = 1, #tarpeet do
            xPlayer.removeInventoryItem(tarpeet[i].item, tarpeet[i].maara)
        end
        if ase then
            xPlayer.addWeapon(itemi, 0)
        else
            xPlayer.addInventoryItem(itemi, 1)
        end
        TriggerClientEvent('esx:showNotification', _source, 'Kasasit '.. label)
        Log("**   KASASI ITEMIN\nTUOTE: " .. label.. "**", '0', GetPlayerName(_source), "Civikin Kasaus logit")
    else
        TriggerClientEvent('esx:showNotification', _source, "Sinulta puuttuu osia")
    end
end)

RegisterServerEvent('civikki_kasaus:HaeServerist')
AddEventHandler('civikki_kasaus:HaeServerist', function()
	TriggerClientEvent('civikki_kasaus:TuoClienttiin', source, ValmistusTarpeet)
end)

function Log(m, c, t, n)
    local co = {
        {
            ["color"] = c,
            ["title"] = t,
            ["description"] = m,
            ["footer"] = {
                ["text"] = os.date("%x | %X")
            },
        }
    }

    PerformHttpRequest(webhook, function(status, text, headers)
		if status ~= 204 then
			print("logi")
		end
    end, 'POST', json.encode({username = n, embeds = co}), { ['Content-Type'] = 'application/json'})
end