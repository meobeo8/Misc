local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Events = ReplicatedStorage:FindFirstChild("Events")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hmr = char:FindFirstChild("HumanoidRootPart")
local PlayerGUI = plr:FindFirstChildOfClass("PlayerGui")

loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/elgato/refs/heads/a/BoostFPS.lua"))()

for _, v in pairs({"Blur", "Sky", "SunRays", "ColorCorrection", "Bloom"}) do
    local obj = game.Lighting:FindFirstChild(v)
    if obj then
        game.Debris:AddItem(obj, 0)
    end
end

function AC(val)
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        if not val then
            if char.HumanoidRootPart:FindFirstChild("Anchor") then
                game.Debris:AddItem(char.HumanoidRootPart:FindFirstChild("Anchor"), 0.2)
            end
            task.delay(0.2, function()
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.PlatformStand = false
                end
            end)
            return
        end
        if not char.HumanoidRootPart:FindFirstChild("Anchor") then
            char.Humanoid.PlatformStand = true
            local new = Instance.new("BodyVelocity", char.HumanoidRootPart)
            new.Name = "Anchor"
            new.MaxForce = Vector3.new(1, 1, 1) * 999999
            new.Velocity = Vector3.new(0, 0, 0)
        end
    end
end

function TP(Pos)
    if hmr then
        hmr.CFrame = Pos
    end
end

function getclose2()
    if not plr.Character or not hmr then return nil, math.huge end

    local pos11 = hmr.Position
    local close2 = nil
    local close1 = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local plrpos1 = player.Character.HumanoidRootPart.Position
            local distance = (pos11 - plrpos1).Magnitude

            if distance < close1 then
                close1 = distance
                close2 = player
            end
        end
    end

    return close2, close1
end

local hehhe = true

if hehhe then
    task.spawn(function()
        while task.wait() do
            while not plr.Character:FindFirstChild("HumanoidRootPart") do
                task.wait()
            end

            AC(true)

            local targetplr11, distance = getclose2()

            if targetplr11 and targetplr11.Character and distance <= 1000 then
                local targetplr22 = targetplr11.Character:FindFirstChild("HumanoidRootPart")

                if targetplr22 then
                    targetplr22.Size = Vector3.new(20, 20, 20)
                    TP(targetplr22.CFrame * CFrame.new(0, 0, -20))

                    if not char:FindFirstChild("M1") then
                        local new = Instance.new("Model", char)
                        new.Name = "M1"
                        game.Debris:AddItem(new, 0.1)
                        local args = {
                            [1] = {
                                ["AttackInfo"] = {
                                    ["AttackIndex"] = 0,
                                    ["ComboIndex"] = 0
                                },
                                ["WorldTargetPoint"] = targetplr22.Position
                            }
                        }

                        Events:WaitForChild("WCFPJ"):FireServer(unpack(args))
                    end
                end
            end
        end
    end)
end
