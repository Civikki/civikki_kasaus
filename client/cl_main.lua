local menuauki = false

ESX = nil

paskat = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerServerEvent('civikki_kasaus:HaeServerist')

RegisterNetEvent('civikki_kasaus:MenuAuki')
AddEventHandler('civikki_kasaus:MenuAuki', function()
    if not menuauki then
        menuauki = true

        local elements = {}
        for i=1, #paskat do
            label = paskat[i].label
            itemi = paskat[i].itemi
            tarpeet = paskat[i].tarpeet
            ase = paskat[i].ase
            table.insert(elements, {label = label, itemi = itemi, tarpeet = tarpeet, ase = ase})
        end
    
        Wait(1000)
        
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'CRAFTMENU',
            {
                title    = 'Crafti menu',
                align    = 'center',
                elements = elements, 
            },
            function(data, menu)
                local label = data.current.label
                local itemi = data.current.itemi
                local tarpeet = data.current.tarpeet
                local ase = data.current.ase
                TriggerServerEvent('civikki_kasaus:Kasaus', label, itemi, tarpeet, ase)
                menuauki = false
        end,
        function(data, menu)  
            menuauki = false
            menu.close()
        end)

    end
end)

RegisterNetEvent('civikki_kasaus:TuoClienttiin')
AddEventHandler('civikki_kasaus:TuoClienttiin', function(s)
    paskat = s
end)