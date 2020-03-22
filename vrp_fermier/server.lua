local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_biz")

RegisterNetEvent("dat_Faina")
AddEventHandler("dat_Faina",function()
    local user_id = vRP.getUserId({source})
    local chance = math.random(10)
    vRP.giveInventoryItem({user_id,"faina",chance,true})
end)


RegisterNetEvent("fermier_sell")
AddEventHandler("fermier_sell",function()
    local user_id = vRP.getUserId({source})
    local cantitate = vRP.getInventoryItemAmount({user_id,"faina"})
    local cantitate = parseInt(cantitate)
    local price = math.random(40, 70)
    local amount = price * cantitate
    if cantitate > 0  then 
        print(cantitate)
    vRP.giveMoney({user_id, amount})
    vRP.tryGetInventoryItem({user_id,"faina",cantitate,false})
    vRPclient.notify(source,{"~y~ Ai vandut ["..cantitate.."KG] de faina pentru ~r~"..amount})
    else
        vRPclient.notify(source,{"~r~Nu ai deloc faina!"})
    end
end)