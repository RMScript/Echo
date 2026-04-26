--[[
    ECHO UI ENGINE V3 - HIGH FIDELITY DESIGN
    Nama: Echo | Map: Violence District
    Status: Global Tab (100% Visual Matching)
]]

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("echo") then CoreGui:FindFirstChild("echo"):Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "echo"
ScreenGui.Parent = CoreGui

-- === MAIN WINDOW ===
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 650, 0, 480)
Main.Position = UDim2.new(0.5, -325, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

-- Efek Stroke pinggiran (Bikin mewah)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Color = Color3.fromRGB(35, 35, 35)
MainStroke.Parent = Main

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 4)
UICornerMain.Parent = Main

-- === SIDEBAR ===
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 0, 60)
Logo.Text = "echo"
Logo.TextColor3 = Color3.fromRGB(0, 255, 127)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 22
Logo.BackgroundTransparency = 1
Logo.Parent = Sidebar

local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(1, 0, 1, -80)
TabHolder.Position = UDim2.new(0, 0, 0, 70)
TabHolder.BackgroundTransparency = 1
TabHolder.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabHolder
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 5)

-- === CONTENT CONTAINER ===
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -175, 1, -20)
Container.Position = UDim2.new(0, 170, 0, 10)
Container.BackgroundTransparency = 1
Container.Parent = Main

-- === UI BUILDER FUNCTIONS ===
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 0
    Page.Parent = Container

    local Layout = Instance.new("UIGridLayout")
    Layout.CellSize = UDim2.new(0.48, 0, 0.45, 0) -- Bikin 2 kolom kotak
    Layout.CellPadding = UDim2.new(0.04, 0, 0.04, 0)
    Layout.Parent = Page
    
    return Page
end

local function CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Section.BorderSizePixel = 0
    Section.Parent = parent

    local SectionStroke = Instance.new("UIStroke")
    SectionStroke.Color = Color3.fromRGB(30, 30, 30)
    SectionStroke.Parent = Section

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -10, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = title:upper()
    Title.TextColor3 = Color3.fromRGB(150, 150, 150)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 11
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Section
    
    local ItemList = Instance.new("UIListLayout")
    ItemList.Padding = UDim.new(0, 5)
    ItemList.Parent = Section
    ItemList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    -- Padding buat isi dalem kotak
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 35)
    UIPadding.Parent = Section
    
    return Section
end

-- === TAB BUTTON LOGIC ===
local function AddTab(name, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundTransparency = 1
    Btn.Text = "      " .. name
    Btn.TextColor3 = Color3.fromRGB(100, 100, 100)
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.LayoutOrder = order
    Btn.Parent = TabHolder
    
    local Page = CreatePage(name)
    
    Btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Container:GetChildren()) do v.Visible = false end
        for _, v in pairs(TabHolder:GetChildren()) do 
            if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(100, 100, 100) end
        end
        Page.Visible = true
        Btn.TextColor3 = Color3.fromRGB(0, 255, 127)
    end)
    
    return Page
end

-- === BUILDING THE UI (GLOBAL TAB) ===
local GlobalPage = AddTab("Global", 1)
local KillerPage = AddTab("Killer", 2)
local SurvivorPage = AddTab("Survivor", 3)

-- Kotak "Exploits" (Kiri)
local ExploitSection = CreateSection(GlobalPage, "Exploits")
-- Kotak "Aimbot" (Kanan)
local AimSection = CreateSection(GlobalPage, "Aimbot")

-- Set Default
GlobalPage.Visible = true
TabHolder:GetChildren()[2].TextColor3 = Color3.fromRGB(0, 255, 127)

print("Echo V3: Aesthetic Mode Active.")
