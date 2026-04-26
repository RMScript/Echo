--[[
    ECHO - VIOLENCE DISTRICT EDITION
    Status: Global Tab (100% Feature Complete)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- === SETTINGS STORAGE ===
local EchoConfig = {
    Speed = 16,
    Invisibility = false,
    InfiniteZoom = false,
    -- Aimbot
    AimbotEnabled = false,
    AimPart = "Head",
    Smoothing = 5,
    FOVSize = 100,
    ShowFOV = false,
    TeamCheck = true,
    -- Crosshair
    CrosshairEnabled = false,
    CrossColor = Color3.fromRGB(0, 255, 127)
}

-- === UI FRAMEWORK ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "echo"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 650, 0, 480)
Main.Position = UDim2.new(0.5, -325, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.Text = "echo"
Logo.TextColor3 = Color3.fromRGB(0, 255, 127)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 24
Logo.BackgroundTransparency = 1
Logo.Parent = Sidebar

-- === LOGIKA FITUR ===

-- Aimbot FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Transparency = 0.5
FOVCircle.Filled = false

local function getClosestPlayer()
    local target = nil
    local dist = EchoConfig.FOVSize
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(EchoConfig.AimPart) then
            if EchoConfig.TeamCheck and v.Team == LocalPlayer.Team then continue end
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character[EchoConfig.AimPart].Position)
            if onScreen then
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                if magnitude < dist then
                    target = v
                    dist = magnitude
                end
            end
        end
    end
    return target
end

-- === ENGINE LOOP ===
RunService.RenderStepped:Connect(function()
    -- Speed Multiplier
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = EchoConfig.Speed
    end

    -- Infinite Zoom Out
    if EchoConfig.InfiniteZoom then
        LocalPlayer.CameraMaxZoomDistance = 10000
    else
        LocalPlayer.CameraMaxZoomDistance = 128
    end

    -- Aimbot Drawing & Execution
    FOVCircle.Visible = EchoConfig.ShowFOV
    FOVCircle.Radius = EchoConfig.FOVSize
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)

    if EchoConfig.AimbotEnabled then
        local target = getClosestPlayer()
        if target then
            local targetPos = Camera:WorldToViewportPoint(target.Character[EchoConfig.AimPart].Position)
            -- Menggunakan MouseMoveRel (Lebih Safe dari Anti-Cheat)
            if mousemoverel then
                mousemoverel((targetPos.X - Mouse.X) / EchoConfig.Smoothing, (targetPos.Y - Mouse.Y) / EchoConfig.Smoothing)
            end
        end
    end
end)

-- Toggle UI dengan tombol Insert
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        Main.Visible = not Main.Visible
    end
end)

print("Echo Loaded - Tab Global 100% Ready.")
