--[[
    ECHO ENGINE V2 - VIOLENCE DISTRICT
    Status: Framework Fixed & Navigation Active
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Hapus UI lama jika ada agar tidak double
if CoreGui:FindFirstChild("echo") then
    CoreGui:FindFirstChild("echo"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "echo"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- === MAIN FRAME ===
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 600, 0, 420)
Main.Position = UDim2.new(0.5, -300, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 6)
UICornerMain.Parent = Main

-- === SIDEBAR ===
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 0, 50)
Logo.Text = "echo"
Logo.TextColor3 = Color3.fromRGB(0, 255, 127)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 22
Logo.BackgroundTransparency = 1
Logo.Parent = Sidebar

local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(1, 0, 1, -60)
TabHolder.Position = UDim2.new(0, 0, 0, 60)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabHolder
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 2)

-- === CONTAINER UNTUK HALAMAN ===
local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -160, 1, -10)
Pages.Position = UDim2.new(0, 155, 0, 5)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

-- === SISTEM FUNGSI TAB ===
local function CreateTab(name, layoutOrder)
    -- Tombol Sidebar
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 35)
    TabBtn.BackgroundTransparency = 1
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 14
    TabBtn.LayoutOrder = layoutOrder
    TabBtn.Parent = TabHolder

    -- Halaman Konten
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 0
    Page.Parent = Pages

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 10)
    PageList.Parent = Page

    -- Logika Klik
    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(Pages:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        for _, v in pairs(TabHolder:GetChildren()) do
            if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(150, 150, 150) end
        end
        Page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(0, 255, 127)
    end)

    return Page
end

-- === PEMBUATAN TAB (Sesuai Urutan Kamu) ===
local GlobalPage = CreateTab("Global", 1)
local KillerPage = CreateTab("Killer", 2)
local SurvivorPage = CreateTab("Survivor", 3)
local AntiAimPage = CreateTab("Anti-Aim", 4)
local VisualPage = CreateTab("Visual", 5)
local TeleportPage = CreateTab("Teleport", 6)
local MiscPage = CreateTab("Misc", 7)
local SettingsPage = CreateTab("Settings", 8)

-- === FUNGSI TAMBAH KOMPONEN (Toggle) ===
local function AddToggle(parent, text)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -50, 0.5, -10)
    Btn.Text = ""
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Parent = Frame
    
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(40, 40, 40)
    end)
end

-- === ISI AWAL (BIAR GA KOSONG) ===
AddToggle(GlobalPage, "Enable Aimbot")
AddToggle(GlobalPage, "Team Check")
AddToggle(GlobalPage, "Speed Hack")
AddToggle(KillerPage, "Hitbox Expander")
AddToggle(KillerPage, "Instant Kill")

-- Set Default
GlobalPage.Visible = true
TabHolder:GetChildren()[2].TextColor3 = Color3.fromRGB(0, 255, 127) -- Global

print("Echo Hub Fixed. Try Now!")
