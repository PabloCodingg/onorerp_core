--[[
  This file is part of Onore RolePlay.

  Copyright (c) Onore RolePlay - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

OnoreServerUtils = {}

OnoreServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

OnoreServerUtils.trace = function(message, prefix)
    print("[^1Onore^7] ("..prefix.."^7) "..message.."^7")
end

local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

OnoreServerUtils.webhook = function(message,color,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =webhookColors[color],
            ["footer"]=  {
                ["text"]= "Onore Logs",
            },
        }
    }
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "Onore Logs",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


Citizen.CreateThread(function()
    while true do
        Wait(30000)
        local restrictedZones, publicZones = 0, 0
        local restrictedBlips, publicBlips = 0, 0
        ---@param zone Zone
        for _,zone in pairs(OnoreSZonesManager.list) do
            if zone:isRestricted() then
                restrictedZones = restrictedZones + 1
            else
                publicZones = publicZones + 1
            end
        end
        ---@param blip Blip
        for _,blip in pairs(OnoreSBlipsManager.list) do
            if blip:isRestricted() then
                restrictedBlips = restrictedBlips + 1
            else
                publicBlips = publicBlips + 1
            end
        end
        OnoreServerUtils.trace(("Zones: %s%i%s (+%s%i%s) | Blips: %s%i%s (+%s%i%s)"):format(
                "^2",
                publicZones,
                "^7",
                "^3",
                restrictedZones,
                "^7",
                "^2",
                publicBlips,
                "^7",
                "^3",
                restrictedBlips,
                "^7"
        ),OnorePrefixes.dev)
    end
end)