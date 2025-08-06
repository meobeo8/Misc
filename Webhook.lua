--[[
Made by griffin
Discord: @griffindoescooking
Github: https://github.com/idonthaveoneatm
]]--

local webhookLibrary = {}
local HttpService = cloneref(game:GetService("HttpService"))
local request = request or httprequest or http_request

function webhookLibrary.createMessage(properties)
    assert(properties.Url, "Url required")
    assert(properties.username, "username required")
    assert(properties.content, "content required")

    local requestTable = {
        Url = properties.Url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = {
            ["username"] = properties.username,
            ["content"] = properties.content or "",
            ["embeds"] = {}
        }
    }

    local webhookFunctions = {}
    local EmbedIndex = 0

    function webhookFunctions.addEmbed(title, color, description)
        assert(title, "title required")
        assert(color, "color required")
        assert(description, "description required")

        EmbedIndex += 1
        local embedIndex = EmbedIndex
        local hour = tonumber(os.date("%H"))
        local ampm = hour < 12 and "SA" or "CH"
        local timestamp = os.date("%d/%m/%Y %I:%M ") .. ampm

        requestTable.Body.embeds[embedIndex] = {
            ["title"] = title,
            ["color"] = tonumber(color),
            ["description"] = description,
            ["fields"] = {},
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1374106941667807333/1396504088706945115/FB_IMG_1752161332671.jpg"
            },
            ["footer"] = {
                ["text"] = "discord.gg/bUxz4epxaN • " .. timestamp
            }
        }

        local embedFunctions = {}

        function embedFunctions.addField(name, value)
            assert(name, "name required")
            assert(value, "value required")
            table.insert(requestTable.Body.embeds[embedIndex].fields, {
                ["name"] = name,
                ["value"] = value
            })
        end

        return embedFunctions
    end

    function webhookFunctions.sendMessage()
        requestTable.Body = HttpService:JSONEncode(requestTable.Body)
        return request(requestTable)
    end

    return webhookFunctions
end

return webhookLibrary
