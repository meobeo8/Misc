repeat wait(0.1) until game:IsLoaded() and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/Main/Library.lua"))()

local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local plr = Players.LocalPlayer
local PlayerGUI = plr:WaitForChild("PlayerGui")

function _CreateCooldown(name, cd)
    if plr and not plr:FindFirstChild(name) then
        local cc = Instance.new("IntValue")
        cc.Name = name
        cc.Parent = plr
        Debris:AddItem(cc, cd)
    end
end

function TP(Pos)
    if Pos ~= nil then
        plr.Character.HumanoidRootPart.CFrame = Pos
    end
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()

local OwO = library:Window("Youtube: @tranvanbao1411")
local OwO1 = library:Window("SKILL")

OwO:Slider("Delay Auto Win", 0, 999, 200, function(value)
    _G.slider1 = value
end)

OwO:Toggle("Enabled Auto Win", false, function(bool)
    _G.Win = bool
    if bool then
        task.spawn(function()
            while _G.Win do
                task.wait(0.1)
                -- if not plr.Character:FindFirstChild("HumanoidRootPart") then continue end
                if not plr:FindFirstChild("_CD") then
                    _CreateCooldown("_CD", _G.slider1)
                    TP(CFrame.new(-37.8360786, 367.299927, 878.52301, -1, 0, 0, 0, 1, 0, 0, 0, -1))
                end
            end
        end)
    end
end)

OwO:Button("Instant Win", function()
    TP(CFrame.new(-37.8360786, 367.299927, 878.52301, -1, 0, 0, 0, 1, 0, 0, 0, -1))
end)

---------------------

local _ListSkill = {}

for _, _Skillgato in ipairs(PlayerGUI.Tranformar.Characters:GetChildren()) do
    table.insert(_ListSkill, _Skillgato.Name)
end

OwO1:Dropdown("Select Skill", _ListSkill, function(name)
    _G.SelectSkill = name
    ReplicatedStorage.MorphRequest:FireServer(_G.SelectSkill)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F and _G.SelectSkill then
        ReplicatedStorage.SkillEvent:FireServer(_G.SelectSkill)
    end
end)

OwO1:Button("Reset Character", function()
    plr.Character.Humanoid.Health = 0
end)

OwO1:Button("Infinite Yield", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)
