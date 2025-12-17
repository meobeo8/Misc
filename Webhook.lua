--[[
Made by griffin (remake by ChatGPT)
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

        local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")

        requestTable.Body.embeds[embedIndex] = {
            ["title"] = title,
            ["color"] = tonumber(color),
            ["description"] = description,
            ["fields"] = {},
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1366160415444439160/1450846645045694474/solix_logo-min_1.png?ex=694405bb&is=6942b43b&hm=084bc5cd54d82d66ac7f79fdd90c412df5071e69d1c70b9a896f707ac44c8606"
            },
            ["footer"] = {
                ["text"] = "discord.gg/solixhub"
            },
            ["timestamp"] = timestamp
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
