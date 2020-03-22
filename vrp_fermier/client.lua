local fieldX, fieldY, fieldZ = 2037.3203125,4908.79296875,41.736812591553
local tractorX, tractorY, tractorZ =  2014.8122558594,4980.541015625,41.226894378662 
local vandutX, vandutY, vandutZ = 2414.1804199219,4991.8969726563,46.244136810303
local fermierX, fermierY, fermierZ = 2415.5329589844,4993.0190429688,46.215446472168
cursa = false
secunde = 5
started = false


local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  } 




local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end



RegisterNUICallback("fermier",function(data)
    if data == "exit" then 
        ToggleActionMenu()
    else
        ToggleActionMenu()
        TriggerServerEvent("fermier_sell")
    end
end)


Citizen.CreateThread(function()
    addBLIP(vandutX, vandutY, vandutZ,"Punct Vanzare",12,5)
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local x, y, z = table.unpack(GetEntityCoords(ped,false))
    
         if GetDistanceBetweenCoords(x,y,z,vandutX,vandutY,vandutZ,false) < 5.0 then 
            SetTextComponentFormat('STRING')
            AddTextComponentString('Apasa ~INPUT_CONTEXT~ sa vinzi faina')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            DrawMarker(20, vandutX,vandutY,vandutZ + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            if IsControlJustReleased(1, 51) then 
              --  cursa = true
              ToggleActionMenu()
            end
        end
    end
end)


RegisterNetEvent("cursa_Start")
AddEventHandler("cursa_Start",function()
    Citizen.CreateThread(function()
        while cursa do
            Wait(0)
                if secunde > 0 then 
                    local text = "Cultiva terenul pentru inca : "..secunde.." secunde!"
                    drawScreenText(0.0345, 0.24, 0.0, 0.0, 0.44, "Job Fermier", 240, 233, 40, 255, 1, 7, 1)
                    drawScreenText(0.095, 0.27, 0.0, 0.0, 0.265, text, 255, 255, 255, 255, 1, 7, 1)
                    drawScreenText(0.095, 0.29, 0.0, 0.0, 0.265, "Atentie trebuie sa mentii o viteza de minim 10 KM/H", 240, 40, 47, 255, 1, 7, 1)
                    DrawRect(0.1 --[[ x ]],0.3--[[ y ]],0.2--[[ width ]],0.075--[[ height ]],67, 126, 0, 150--[[ rgb ]] )
                        
                    else
                        cursa = false
                        started = false
                        TriggerServerEvent("dat_Faina")
                        secunde = 3
                        local ped = GetPlayerPed(-1)
                        local vehicle = GetVehiclePedIsIn(ped,false)
                        DeleteEntity(vehicle)
                       
                end
                SetTextComponentFormat('STRING')
                AddTextComponentString('Apasa ~INPUT_VEH_DUCK~ sa te opresti')
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)

                if IsControlJustReleased(0, Keys["X"]) then
                    cursa = false
                    started = false
                   
                    secunde = 3
                    local ped = GetPlayerPed(-1)
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    DeleteEntity(vehicle)
                end
        end
      
    end)
end)
--[[
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if secunde == 0 then 
            local ped = GetPlayerPed(-1)
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
            if GetDistanceBetweenCoords(x,y,z,fermierX,fermierY,fermierZ,false) < 2 then
                if IsControlJustReleased(1,51) then
                    TriggerServerEvent("dat_Faina")
                    secunde = 120
                    cursa = false
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    DeleteEntity(vehicle)
                end
            end
        end
    end
end)
]]
Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local ped = GetPlayerPed(-1)
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
        local vehicle = GetVehiclePedIsIn(ped,false)
        
        local model =  GetEntityModel(vehicle)
        local vname = GetDisplayNameFromVehicleModel(model)
        local speed = GetEntitySpeed(vehicle, false) * 3.6
        local distance = GetDistanceBetweenCoords(x,y,z,fieldX,fieldY,fieldZ,false)
            Citizen.Wait(1000)
        if cursa == true  and distance < 60 and speed > 10 and model == GetHashKey("tractor") then         
           if secunde > 0 then 
            secunde = secunde -1
           end
            
          
        end
    end
end)



function drawScreenText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextCentre(center)
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


Citizen.CreateThread(function()
    addBLIP(tractorX,tractorY,tractorZ,"Ferma",12,5)
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local x, y, z = table.unpack(GetEntityCoords(ped,false))

         if GetDistanceBetweenCoords(x,y,z,tractorX, tractorY, tractorZ,false) < 5.0 and cursa == false  then 
            DrawMarker(20, tractorX,tractorY,tractorZ + 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
            SetTextComponentFormat('STRING')
            AddTextComponentString('Apasa ~INPUT_CONTEXT~ sa iei un tractor')
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustReleased(1, 51) and cursa == false then 
                cursa = true
                started = true
                spawnCar("tractor")
                
            end
        end
    end
end)

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, x , y , z + 1, 0.0, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) -- put player inside
    SetEntityAsMissionEntity(vehicle, true, true)
    TriggerEvent("cursa_Start")
end

function drawSecunde(text)
    SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.40, 0.40)
			SetTextColour(255, 255, 255, 255)
			SetTextDropshadow(0, 255, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextRightJustify(true)
			SetTextWrap(0,0.95)
			SetTextEntry("STRING")

			AddTextComponentString(text)
            DrawText(0.1, 0.0001)
           
end

function addBLIP(x,y,z,name,type,color)
blip = AddBlipForCoord(x, y, z)
SetBlipSprite(blip, type)
SetBlipDisplay(blip, 4)
SetBlipScale(blip, 0.9)
SetBlipColour(blip, color)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(name)
EndTextCommandSetBlipName(blip)
end