--==================================================
-- KIO TSB
-- LOADING + KIO TOGGLE + FIX LAG
-- ROBLOX STUDIO - LocalScript
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--==================================================
-- XÓA UI CŨ
--==================================================

local oldUI = playerGui:FindFirstChild("KiominhmiuTSB")

if oldUI then
oldUI:Destroy()
end

--==================================================
-- SCREEN GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "KiominhmiuTSB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

--==================================================
-- LOADING SCREEN
--==================================================

local loading = Instance.new("Frame")
loading.Size = UDim2.fromScale(1,1)
loading.Position = UDim2.fromScale(0,0)
loading.BackgroundColor3 = Color3.fromRGB(10,10,15)
loading.BorderSizePixel = 0
loading.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1,0.15)
title.Position = UDim2.fromScale(0,0.34)
title.BackgroundTransparency = 1
title.Text = "kiominhmiu"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = loading

local percent = Instance.new("TextLabel")
percent.Size = UDim2.fromScale(1,0.08)
percent.Position = UDim2.fromScale(0,0.50)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.new(1,1,1)
percent.Font = Enum.Font.Gotham
percent.TextScaled = true
percent.Parent = loading

local barBack = Instance.new("Frame")
barBack.Size = UDim2.fromScale(0.55,0.025)
barBack.Position = UDim2.fromScale(0.225,0.60)
barBack.BackgroundColor3 = Color3.fromRGB(45,45,55)
barBack.BorderSizePixel = 0
barBack.Parent = loading

local barBackCorner = Instance.new("UICorner")
barBackCorner.CornerRadius = UDim.new(1,0)
barBackCorner.Parent = barBack

local bar = Instance.new("Frame")
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.new(1,1,1)
bar.BorderSizePixel = 0
bar.Parent = barBack

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1,0)
barCorner.Parent = bar

--==================================================
-- LOADING %
--==================================================

for i = 0,100 do
percent.Text = i .. "%"
bar.Size = UDim2.fromScale(i / 100,1)
task.wait(0.015)
end

task.wait(0.25)

--==================================================
-- FADE LOADING
--==================================================

TweenService:Create(
loading,
TweenInfo.new(0.7,Enum.EasingStyle.Quad),
{BackgroundTransparency = 1}
):Play()

for _,obj in ipairs(loading:GetDescendants()) do

if obj:IsA("TextLabel") then

	TweenService:Create(
		obj,
		TweenInfo.new(0.5),
		{TextTransparency = 1}
	):Play()

elseif obj:IsA("Frame") then

	TweenService:Create(
		obj,
		TweenInfo.new(0.5),
		{BackgroundTransparency = 1}
	):Play()

end

end

task.wait(0.7)

loading:Destroy()

--==================================================
-- MAIN PANEL
--==================================================

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(260,210)
main.Position = UDim2.new(0.5,-130,0.5,-105)
main.BackgroundColor3 = Color3.fromRGB(20,20,27)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,14)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Transparency = 0.5
stroke.Parent = main

--==================================================
-- TITLE
--==================================================

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1,-20,0,40)
header.Position = UDim2.fromOffset(10,5)
header.BackgroundTransparency = 1
header.Text = "kiominhmiu tsb"
header.TextColor3 = Color3.new(1,1,1)
header.Font = Enum.Font.GothamBold
header.TextSize = 20
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

--==================================================
-- FIX LAG BUTTON
--==================================================

local fixLag = Instance.new("TextButton")
fixLag.Size = UDim2.fromOffset(100,32)
fixLag.Position = UDim2.fromOffset(15,55)
fixLag.BackgroundColor3 = Color3.fromRGB(35,35,45)
fixLag.Text = "Fix Lag"
fixLag.TextColor3 = Color3.new(1,1,1)
fixLag.Font = Enum.Font.GothamBold
fixLag.TextSize = 14
fixLag.BorderSizePixel = 0
fixLag.AutoButtonColor = true
fixLag.Parent = main

local fixCorner = Instance.new("UICorner")
fixCorner.CornerRadius = UDim.new(0,9)
fixCorner.Parent = fixLag

--==================================================
-- FIX LAG / CLEAN EFFECTS
--==================================================

local fixing = false

local effectClasses = {
ParticleEmitter = true,
Trail = true,
Beam = true,
Smoke = true,
Fire = true,
Sparkles = true
}

local nameKeywords = {
"debris",
"rock",
"rocks",
"ground",
"rubble",
"dust",
"effect",
"effects",
"fragment",
"skilldebris"
}

local function hasKeyword(name)
name = string.lower(name)

for _,keyword in ipairs(nameKeywords) do

	if string.find(name,keyword,1,true) then
		return true
	end

end

return false

end

local function cleanObject(obj)

if not obj or not obj.Parent then
	return
end

-- Xóa hiệu ứng
if effectClasses[obj.ClassName] then
	obj:Destroy()
	return
end

-- Xóa đá / debris / effect
if obj:IsA("BasePart") and hasKeyword(obj.Name) then
	obj:Destroy()
	return
end

end

local function fixLagNow()

for _,obj in ipairs(Workspace:GetDescendants()) do
	cleanObject(obj)
end

end

fixLag.MouseButton1Click:Connect(function()

fixing = not fixing

if fixing then

	fixLag.Text = "Fix Lag: ON"
	fixLag.BackgroundColor3 = Color3.fromRGB(45,80,55)

	fixLagNow()

else

	fixLag.Text = "Fix Lag: OFF"
	fixLag.BackgroundColor3 = Color3.fromRGB(35,35,45)

end

end)

--==================================================
-- TỰ DỌN OBJECT MỚI
--==================================================

Workspace.DescendantAdded:Connect(function(obj)

if not fixing then
	return
end

task.defer(function()

	if fixing then
		cleanObject(obj)
	end

end)

end)

--==================================================
-- NÚT KIO
--==================================================

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(55,55)
toggle.Position = UDim2.new(0,15,0.5,-27)
toggle.BackgroundColor3 = Color3.fromRGB(25,25,32)
toggle.Text = "kio"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 17
toggle.BorderSizePixel = 0
toggle.AutoButtonColor = true
toggle.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1,0)
toggleCorner.Parent = toggle

--==================================================
-- KÉO NÚT KIO
--==================================================

local dragging = false
local dragStart
local startPosition
local dragInput

toggle.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

	dragging = true
	dragStart = input.Position
	startPosition = toggle.Position

	input.Changed:Connect(function()

		if input.UserInputState == Enum.UserInputState.End then
			dragging = false
		end

	end)

end

end)

toggle.InputChanged:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then

	dragInput = input

end

end)

UserInputService.InputChanged:Connect(function(input)

if input ~= dragInput then
	return
end

if not dragging then
	return
end

local delta = input.Position - dragStart

toggle.Position = UDim2.new(
	startPosition.X.Scale,
	startPosition.X.Offset + delta.X,
	startPosition.Y.Scale,
	startPosition.Y.Offset + delta.Y
)

end)

--==================================================
-- BẬT / TẮT BẢNG
--==================================================

toggle.Activated:Connect(function()

main.Visible = not main.Visible

end)

--==================================================
-- HOÀN TẤT
--==================================================
