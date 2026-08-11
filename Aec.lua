--==================================================
-- 💜 PURPLE SPEED UI - COMPACT VERSION
-- สำหรับ Roblox เกมของคุณเอง
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local speedEnabled = false
local speedValue = 16

--==================================================
-- CHARACTER
--==================================================

local function getHumanoid()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()

player.CharacterAdded:Connect(function(character)

	humanoid = character:WaitForChild("Humanoid")

	if speedEnabled then
		humanoid.WalkSpeed = speedValue
	end
end)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "PurpleSpeedUI"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN FRAME
--==================================================

local main = Instance.new("Frame")

-- ⭐ เล็ก แต่ปุ่มใช้งานง่าย
main.Size = UDim2.fromOffset(190, 82)
main.Position = UDim2.new(0.5, -95, 0, 80)

main.BackgroundColor3 = Color3.fromRGB(45, 20, 65)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 11)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(160, 80, 255)
stroke.Thickness = 1
stroke.Parent = main

--==================================================
-- DRAG SYSTEM
--==================================================

local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end

		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- SPEED BUTTON
--==================================================

local speedButton = Instance.new("TextButton")

-- ⭐ ใหญ่ขึ้น กดง่าย
speedButton.Size = UDim2.fromOffset(125, 38)
speedButton.Position = UDim2.fromOffset(8, 8)

speedButton.BackgroundColor3 = Color3.fromRGB(100, 45, 160)
speedButton.BorderSizePixel = 0

speedButton.Text = "⚡ SPEED: OFF"
speedButton.TextColor3 = Color3.new(1,1,1)
speedButton.TextSize = 14
speedButton.Font = Enum.Font.GothamBold

speedButton.Parent = main

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedButton

--==================================================
-- SPEED INPUT
--==================================================

local speedBox = Instance.new("TextBox")

-- ⭐ กว้างเท่ากับปุ่ม SPEED
speedBox.Size = UDim2.fromOffset(125, 27)
speedBox.Position = UDim2.fromOffset(8, 48)

speedBox.BackgroundColor3 = Color3.fromRGB(30, 15, 45)
speedBox.BorderSizePixel = 0

speedBox.PlaceholderText = "ใส่ความเร็ว"
speedBox.Text = tostring(speedValue)

speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.PlaceholderColor3 = Color3.fromRGB(170,150,180)

speedBox.TextSize = 12
speedBox.Font = Enum.Font.Gotham

speedBox.ClearTextOnFocus = false
speedBox.Parent = main

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 7)
boxCorner.Parent = speedBox

--==================================================
-- DELETE BUTTON
--==================================================

local deleteButton = Instance.new("TextButton")

deleteButton.Size = UDim2.fromOffset(25, 25)
deleteButton.Position = UDim2.new(1, -32, 0, 7)

deleteButton.BackgroundColor3 = Color3.fromRGB(125, 50, 150)
deleteButton.BorderSizePixel = 0

deleteButton.Text = "×"
deleteButton.TextColor3 = Color3.new(1,1,1)
deleteButton.TextSize = 17
deleteButton.Font = Enum.Font.GothamBold

deleteButton.Parent = main

local deleteCorner = Instance.new("UICorner")
deleteCorner.CornerRadius = UDim.new(1, 0)
deleteCorner.Parent = deleteButton

--==================================================
-- MINI CIRCLE
--==================================================

local mini = Instance.new("TextButton")

mini.Size = UDim2.fromOffset(38, 38)
mini.Position = UDim2.new(0.5, -19, 0, 80)

mini.BackgroundColor3 = Color3.fromRGB(110, 50, 180)
mini.BorderSizePixel = 0

mini.Text = "S"
mini.TextColor3 = Color3.new(1,1,1)
mini.TextSize = 16
mini.Font = Enum.Font.GothamBold

mini.Visible = false
mini.Parent = gui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(1, 0)
miniCorner.Parent = mini

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(190, 100, 255)
miniStroke.Thickness = 1
miniStroke.Parent = mini

--==================================================
-- SPEED CONTROL
--==================================================

local function applySpeed()

	if humanoid then

		if speedEnabled then
			humanoid.WalkSpeed = speedValue
		else
			humanoid.WalkSpeed = 16
		end

	end
end

--==================================================
-- SPEED ON / OFF
--==================================================

speedButton.MouseButton1Click:Connect(function()

	speedEnabled = not speedEnabled

	if speedEnabled then

		speedButton.Text = "⚡ SPEED: ON"

		speedButton.BackgroundColor3 =
			Color3.fromRGB(145, 70, 220)

	else

		speedButton.Text = "⚡ SPEED: OFF"

		speedButton.BackgroundColor3 =
			Color3.fromRGB(100, 45, 160)

	end

	applySpeed()
end)

--==================================================
-- SPEED INPUT
--==================================================

speedBox.FocusLost:Connect(function()

	local number = tonumber(speedBox.Text)

	if number then

		speedValue = number

		if speedEnabled then
			applySpeed()
		end

	else

		speedBox.Text =
			tostring(speedValue)

	end
end)

--==================================================
-- DELETE / RESTORE UI
--==================================================

deleteButton.MouseButton1Click:Connect(function()

	main.Visible = false
	mini.Visible = true

end)

mini.MouseButton1Click:Connect(function()

	main.Visible = true
	mini.Visible = false

end)

--==================================================
-- KEEP SPEED AFTER CHARACTER RESPAWN
--==================================================

task.spawn(function()

	while task.wait(0.2) do

		if speedEnabled and humanoid then

			if humanoid.WalkSpeed ~= speedValue then
				humanoid.WalkSpeed = speedValue
			end

		end

	end

end)
