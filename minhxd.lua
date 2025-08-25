if game.PlaceId == 103754275310547 then
    repeat task.wait() until game:IsLoaded()

    local Players           = cloneref(game:GetService("Players"))
    local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
    local VirtualUser       = cloneref(game:GetService("VirtualUser"))
    local HttpService       = cloneref(game:GetService("HttpService"))
    local Workspace         = cloneref(game:GetService("Workspace"))
    local Lighting          = cloneref(game:GetService("Lighting"))
    local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
    local Debris            = cloneref(game:GetService("Debris"))

    repeat task.wait() until Players.LocalPlayer
    local plr = Players.LocalPlayer

    repeat task.wait() until plr:FindFirstChildOfClass("PlayerGui")
    repeat task.wait() until plr.Character
    repeat task.wait() until plr.Character:FindFirstChild("HumanoidRootPart")
    repeat task.wait() until plr.Character:FindFirstChild("Humanoid")

    local PlayerGUI = plr:FindFirstChildOfClass("PlayerGui")
    local Modules   = ReplicatedStorage:WaitForChild("Modules", 5)
    local ReplicateService = require(ReplicatedStorage:WaitForChild("Client"):WaitForChild("ReplicateService"))

    plr.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    end)

    local function CreateValue(name, cd, path)
        local cc = Instance.new("IntValue")
        cc.Name = name
        cc.Parent = path
        if cd then
            Debris:AddItem(cc, cd)
        end
    end

    local function FindPath(v, ...)
        for _, n in ipairs({...}) do
            if not v then return nil end
            v = v:FindFirstChild(n)
        end
        return v
    end

    local function WaitPath(v, ...)
        for _, n in ipairs({...}) do
            if not v then return nil end
            v = v:WaitForChild(n)
        end
        return v
    end

    local function CC(target)
        if target then
            GuiService.SelectedObject = target
            if GuiService.SelectedObject == target then
                task.delay(0.1, function()
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                    task.wait(0.1)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    task.wait(0.1)
                    GuiService.SelectedObject = nil
                end)
            end
        end
    end

    local function GetData1(name, value, parent)
        local ex = parent:FindFirstChild(name)
        if ex and typeof(ex.Value) == typeof(value) then
            return ex
        end
        if ex then ex:Destroy() end

        local vt = typeof(value)
        local nv
        if vt == "number" then
            nv = Instance.new("NumberValue")
        elseif vt == "boolean" then
            nv = Instance.new("BoolValue")
        elseif vt == "string" then
            nv = Instance.new("StringValue")
        elseif vt == "Vector3" then
            nv = Instance.new("Vector3Value")
        elseif vt == "CFrame" then
            nv = Instance.new("CFrameValue")
        elseif vt == "Instance" then
            nv = Instance.new("ObjectValue")
        else
            return nil
        end

        nv.Name = name
        nv.Parent = parent
        return nv
    end

    local function GetData2(tbl, folder)
        local array = #tbl > 0
        if array then
            for i, val in ipairs(tbl) do
                local ks = tostring(i)
                if typeof(val) == "table" then
                    local sub = folder:FindFirstChild(ks)
                    if not sub then
                        sub = Instance.new("Folder")
                        sub.Name = ks
                        sub.Parent = folder
                    end
                    GetData2(val, sub)
                else
                    local vo = GetData1(ks, val, folder)
                    if vo and vo.Value ~= val then
                        vo.Value = val
                    end
                end
            end
        else
            for key, val in pairs(tbl) do
                local ks = tostring(key)
                if typeof(val) == "table" then
                    local sub = folder:FindFirstChild(ks)
                    if not sub then
                        sub = Instance.new("Folder")
                        sub.Name = ks
                        sub.Parent = folder
                    end
                    GetData2(val, sub)
                else
                    local vo = GetData1(ks, val, folder)
                    if vo and vo.Value ~= val then
                        vo.Value = val
                    end
                end
            end
        end
    end

    local client = plr:FindFirstChild("DataService")
    if not client then
        client = Instance.new("Folder")
        client.Name = "DataService"
        client.Parent = plr
    end

    ReplicateService.onDataUpdate:Connect(function(data)
        client:ClearAllChildren()

        GetData2(data, client)
    end)

    local initial = ReplicateService.GetData()
    if initial then
        GetData2(initial, client)
    end

    local webhookUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/Misc/a/Webhook.lua"))()

    local function SendWebhook(hi, ha)
        local WebhookInfo = webhookUtil.createMessage({
            Url = getgenv().minhxd.Webhook,
            username = "minhxd.",
            content = " "
        })

        local e = WebhookInfo.addEmbed("Hunty Zombie", math.random(0, 16777215), "")
        e.addField("Name", plr.Name)
        e.addField(hi, ha)

        local success, err = pcall(function()
            WebhookInfo.sendMessage()
        end)

        if not success then
            warn("Failed to send webhook:", err)
        end
    end

    repeat wait() until Workspace:FindFirstChild("Maps") and plr:FindFirstChild("DataService")

    local DataService = plr:WaitForChild("DataService")
    local PetsFolder = DataService:WaitForChild("Pets")

    for _, v in ipairs(PetsFolder:GetChildren()) do
        CreateValue("Haved", nil, v)
    end

    loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/Data/main/CodeHz.lua"))()

    task.spawn(function()
        while task.wait(0.3) do
            pcall(function()
                if DataService.Coin.Value >= 30000 then
                    for _, v in ipairs(PetsFolder:GetChildren()) do
                        if v:FindFirstChild("Name") and v.Name.Value == "Dragon" and not v:FindFirstChild("Haved") then
                            CreateValue("Haved", nil, v)
                            task.wait(0.1)
                            SendWebhook("Pet", "Dragon")
                            task.wait(0.1)
                            return
                        end
                    end

                    local hi = FindPath(PlayerGUI, "GUI", "RollFrame")
                    if hi and hi.Visible and hi.SkipButton.Visible then
                        if CC then CC(hi.SkipButton) end
                    else
                        ReplicatedStorage:WaitForChild("Packets"):WaitForChild("SpinPetPack"):InvokeServer("legend")
                    end
                end
            end)
        end
    end)
end