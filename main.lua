--[[
    ECHO UI ENGINE - FIXED NAVIGATION
    Map: Violence District
]]

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "echo"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- === MAIN FRAME ===
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 650, 0, 450)
Main.Position = UDim2.new(0.5, -325, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

-- === SIDEBAR ===
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
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

local TabButtonHolder = Instance.new("Frame")
TabButtonHolder.Size = UDim2.new(1, 0, 1, -60)
TabButtonHolder.Position = UDim2.new(0, 0, 0, 60)
TabButtonHolder.BackgroundTransparency = 1
TabButtonHolder.Parent = Sidebar

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = TabButtonHolder

-- === CONTENT AREA (Area Hitam) ===
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -170, 1, -20)
Content.Position = UDim2.new(0, 165, 0, 10)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- === SISTEM TAB ===
local Tabs = {}

function CreateTab(name, order)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name.."_Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.Parent = Content
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.Parent = Page
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.Text = name
    Button.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.LayoutOrder = order
    Button.Parent = TabButtonHolder
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        for _, p in pairs(Content:GetChildren()) do
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        for _, b in pairs(TabButtonHolder:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.new(0.8, 0.8, 0.8) end
        end
        Page.Visible = true
        Button.TextColor3 = Color3.fromRGB(0, 255, 127)
    end)
    
    return Page
end

-- === MEMBUAT TAB SESUAI URUTAN SIXSENSE ===
local GlobalPage = CreateTab("Global", 1)
local KillerPage = CreateTab("Killer", 2)
local SurvivorPage = CreateTab("Survivor", 3)
local AntiAimPage = CreateTab("Anti-Aim", 4)
local VisualPage = CreateTab("Visual", 5)
local TeleportPage = CreateTab("Teleport", 6)
local MiscPage = CreateTab("Misc", 7)
local SettingsPage = CreateTab("Settings", 8)

-- === CONTOH ISI TAB GLOBAL (Exploits) ===
function AddToggle(parent, text, callback)
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(1, -10, 0, 40)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ToggleBtn.Text = "  " .. text .. ": OFF"
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBtn.Parent = parent
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = "  " .. text .. (state and ": ON" or ": OFF")
        ToggleBtn.TextColor3 = state and Color3.fromRGB(0, 255, 127) or Color3.new(1, 1, 1)
        callback(state)
    end)
end

-- Isi Tab Global
AddToggle(GlobalPage, "Invisibility", function(v) print("Invis:", v) end)
AddToggle(GlobalPage, "Infinite Zoom Out", function(v) print("Zoom:", v) end)
AddToggle(GlobalPage, "Speed Multiplier", function(v) print("Speed:", v) end)

-- Set default page
GlobalPage.Visible = true
TabButtonHolder:FindFirstChild("Global").TextColor3 = Color3.fromRGB(0, 255, 127)

print("Echo Engine Fixed: Navigation Ready.")
