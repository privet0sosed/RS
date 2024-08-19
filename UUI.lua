
local lp = game:FindService("Players").LocalPlayer
local PPS = game:FindService("ProximityPromptService")
local UIS = game:FindService("UserInputService")

local DragModule = {
	Add = function(Object: GuiObject)
		local dragToggle, dragStart, startPos, dragInput
		local function updateInput(input)
			local Delta = input.Position - dragStart
			local EndPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			Object.Position = EndPos
		end
		Object.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin) and UIS:GetFocusedTextBox() == nil) then
				dragToggle = true
				dragStart = input.Position
				startPos = Object.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Object.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
}

local function gplr(String)
	local Found = {}
	local strl = String:lower()
	if strl == "me" then
		return {lp}
	else
		for i,v in game:FindService("Players"):GetPlayers() do
			if v.Name:lower():sub(1, #String) == String:lower() and v~=lp then
				if v.Name:lower() == String:lower() then
					table.insert(Found, 1, v)
					break
				end
				table.insert(Found,v)
			end
		end 
	end
	return Found 
end

local function notif(str,dur)
	game:FindService("StarterGui"):SetCore("SendNotification", {
		Title = "UUI",
		Text = str,
		Duration = dur or 3
	})
end

local prox = nil
cons = {
	PPS.PromptShown:Connect(function(prompt: ProximityPrompt, inputType: Enum.ProximityPromptInputType)
		prox = prompt
	end),
	PPS.PromptHidden:Connect(function(prompt: ProximityPrompt)
		prox = nil
	end)
}
local Screen = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextButton")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")
local Sit = Instance.new("TextButton")
local ToggleFly = Instance.new("TextButton")
local TP = Instance.new("TextBox")
local TPB = Instance.new("TextButton")
local PS = Instance.new("TextBox")
local PSta = Instance.new("TextButton")
local PSto = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local MVT = Instance.new("TextButton")
local FSpe = Instance.new("TextBox")
local FreeCam = Instance.new("TextButton")

Screen.Name = tostring(((math.random(53215432)+82705-41*523/125)-math.random(5021953)*523/7629+414-67+83624)/42*551/9+751-7473)
local s = pcall(function()Screen.Parent=game:FindService("CoreGui")end)
if not s then Screen.Parent = lp:WaitForChild("PlayerGui") end
Screen.ResetOnSpawn = false

TextLabel.Parent = Screen
TextLabel.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 400, 0, 30)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Utility UI"
TextLabel.TextColor3 = Color3.new(1,1,1)
TextLabel.TextScaled = true
TextLabel.AutoButtonColor = false

DragModule.Add(TextLabel)

Frame.Parent = TextLabel
Frame.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 1, 0)
Frame.Size = UDim2.new(1, 0, 0, 190)

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0, 20, 0, 20)
TextBox.Size = UDim2.new(0, 220, 0, 30)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Who to yeet (can be shorted)"
TextBox.Text = ""
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.TextScaled = true

TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(1, 0)
TextButton.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(1, -20, 0, 20)
TextButton.Size = UDim2.new(0, 60, 0, 30)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Yeet"
TextButton.TextColor3 = Color3.new(1,1,1)
TextButton.TextScaled = true

Sit.Parent = Frame
Sit.AnchorPoint = Vector2.new(1, 0)
Sit.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
Sit.BorderSizePixel = 0
Sit.Position = UDim2.new(1, -90, 0, 20)
Sit.Size = UDim2.new(0, 60, 0, 30)
Sit.Font = Enum.Font.SourceSans
Sit.Text = "Sit"
Sit.TextColor3 = Color3.new(1,1,1)
Sit.TextScaled = true

ToggleFly.Parent = Frame
ToggleFly.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
ToggleFly.BorderSizePixel = 0
ToggleFly.Position = UDim2.new(0, 160, 0, 60)
ToggleFly.Size = UDim2.new(0, 100, 0, 30)
ToggleFly.Font = Enum.Font.SourceSans
ToggleFly.Text = "Flying: No"
ToggleFly.TextColor3 = Color3.new(1,1,1)
ToggleFly.TextScaled = true

TP.Parent = Frame
TP.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TP.BorderSizePixel = 0
TP.Position = UDim2.new(0, 20, 0, 100)
TP.Size = UDim2.new(0, 220, 0, 30)
TP.Font = Enum.Font.SourceSans
TP.PlaceholderText = "TP to (can be short)"
TP.Text = ""
TP.TextColor3 = Color3.new(1,1,1)
TP.TextScaled = true

TPB.Parent = Frame
TPB.AnchorPoint = Vector2.new(1, 0)
TPB.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
TPB.BorderSizePixel = 0
TPB.Position = UDim2.new(1, -20, 0, 100)
TPB.Size = UDim2.new(0, 60, 0, 30)
TPB.Font = Enum.Font.SourceSans
TPB.Text = "Teleport"
TPB.TextColor3 = Color3.new(1,1,1)
TPB.TextScaled = true

PS.Parent = Frame
PS.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
PS.BorderSizePixel = 0
PS.Position = UDim2.new(0, 20, 0, 140)
PS.Size = UDim2.new(0, 220, 0, 30)
PS.Font = Enum.Font.SourceSans
PS.PlaceholderText = "Times to activate (proximity prompt)"
PS.Text = ""
PS.TextColor3 = Color3.new(1,1,1)
PS.TextScaled = true

PSta.Parent = Frame
PSta.AnchorPoint = Vector2.new(1, 0)
PSta.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
PSta.BorderSizePixel = 0
PSta.Position = UDim2.new(1, -90, 0, 140)
PSta.Size = UDim2.new(0, 60, 0, 30)
PSta.Font = Enum.Font.SourceSans
PSta.Text = "Start"
PSta.TextColor3 = Color3.new(1,1,1)
PSta.TextScaled = true

PSto.Parent = Frame
PSto.AnchorPoint = Vector2.new(1, 0)
PSto.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
PSto.BorderSizePixel = 0
PSto.Position = UDim2.new(1, -20, 0, 140)
PSto.Size = UDim2.new(0, 60, 0, 30)
PSto.Font = Enum.Font.SourceSans
PSto.Text = "Stop"
PSto.TextColor3 = Color3.new(1,1,1)
PSto.TextScaled = true

TextButton_3.Parent = TextLabel
TextButton_3.BackgroundColor3 = Color3.fromRGB(175, 175, 175)
TextButton_3.BorderSizePixel = 0
TextButton_3.Position = UDim2.new(1, -30, 0, 0)
TextButton_3.Size = UDim2.new(0, 30, 0, 30)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "X"
TextButton_3.TextColor3 = Color3.new(0,0,0)
TextButton_3.TextSize = 14

TextButton_4.Parent = TextLabel
TextButton_4.BackgroundColor3 = Color3.fromRGB(175, 175, 175)
TextButton_4.BorderSizePixel = 0
TextButton_4.Position = UDim2.new(1, -60, 0, 0)
TextButton_4.Size = UDim2.new(0, 30, 0, 30)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = "_"
TextButton_4.TextColor3 = Color3.new(0,0,0)
TextButton_4.TextSize = 14

MVT.Parent = Frame
MVT.AnchorPoint = Vector2.new(1, 0)
MVT.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
MVT.BorderSizePixel = 0
MVT.Position = UDim2.new(1, -90, 0, 100)
MVT.Size = UDim2.new(0, 60, 0, 30)
MVT.Font = Enum.Font.SourceSans
MVT.Text = "Move To"
MVT.TextColor3 = Color3.new(1, 1, 1)
MVT.TextScaled = true

FSpe.Parent = Frame
FSpe.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
FSpe.BorderSizePixel = 0
FSpe.Position = UDim2.new(0, 20, 0, 60)
FSpe.Size = UDim2.new(0, 130, 0, 30)
FSpe.Font = Enum.Font.SourceSans
FSpe.PlaceholderText = "Flying Speed (def 3)"
FSpe.Text = ""
FSpe.TextColor3 = Color3.new(1, 1, 1)
FSpe.TextScaled = true

FreeCam.Parent = Frame
FreeCam.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
FreeCam.BorderSizePixel = 0
FreeCam.Position = UDim2.new(0, 270, 0, 60)
FreeCam.Size = UDim2.new(0, 110, 0, 30)
FreeCam.Font = Enum.Font.SourceSans
FreeCam.Text = "Freecam: No"
FreeCam.TextColor3 = Color3.new(1, 1, 1)
FreeCam.TextScaled = true


TextButton_3.MouseButton1Click:Connect(function()
	for i,v in cons do
		v:Disconnect()
	end
	Screen:Destroy()
end)

hidden = false
TextButton_4.MouseButton1Click:Connect(function()
	hidden = not hidden
	TextLabel.Size = hidden and UDim2.new(0, 90, 0, 30) or UDim2.new(0, 400, 0, 30)
	Frame.Visible = not hidden
end)




local running = false
local TPBA = false
TextButton.MouseButton1Click:Connect(function()
	if running then running = false return end
	local Target = gplr(TextBox.Text)
	if Target[1] then
		Target = Target[1]
		running = true

		local ol = lp.Character.HumanoidRootPart.CFrame

		local Thrust = Instance.new('BodyThrust', lp.Character.HumanoidRootPart)
		Thrust.Force = Vector3.new(9999,9999,9999)
		TextButton.Text = "Stop"

		pcall(function()
			repeat
				lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
				Thrust.Location = Target.Character.HumanoidRootPart.Position
				game:FindService("RunService").Heartbeat:wait()
			until not Target.Character or not lp.Character or not Target.Character:FindFirstChild("Head") or not lp.Character:FindFirstChild("Head") or running == false
		end)

		TextButton.Text = "Yeet"
		running = false
		Thrust:Destroy()
	else
		notif("Invalid player")
	end
end)





Sit.MouseButton1Click:Connect(function()
	pcall(function()
		lp.Character.Humanoid.Sit = not lp.Character.Humanoid.Sit
	end)
end)




autopprun = false
PSta.MouseButton1Click:Connect(function()
	autopprun = true
	local num = tonumber(PS.Text) or 1
	for i=1,num or 1 do
		TextLabel.Text = ("Utility UI (AutoPP: %s/%s)"):format(i,num)
		if not prox or not autopprun then break end
		prox:InputHoldBegin()
		if prox.HoldDuration > 0 then
			prox.Triggered:Wait()
		end
		prox:InputHoldEnd()
		task.wait()
	end
	TextLabel.Text = "Utility UI"
end)

PSto.MouseButton1Click:Connect(function()
	autopprun = false
end)




TPLO = false
TpL = false
function tp(MT)
	if TpL and TPLO then TPLO = false return end
	local Target = gplr(TP.Text)
	if Target[1] then
		Target = Target[1]

		pcall(function()
			if MT then
				lp.Character:MoveTo(Target.Character.HumanoidRootPart.Position)
			else
				lp.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
			end
		end)
	else
		notif("Invalid player")
	end
end
TPB.MouseButton1Click:Connect(function()
	tp()
end)
MVT.MouseButton1Click:Connect(function()
	tp(true)
end)




local FActiv = false
local FCActiv = false
function Fly()
	FCActiv = false
	wait()
	local cam = workspace.CurrentCamera
	local Char = lp.Character
	local Human = Char:FindFirstChildOfClass("Humanoid")
	local Torso = Char:FindFirstChild("HumanoidRootPart")

	Human.PlatformStand = true
	Torso.Anchored = true

	local Smo = Vector3.new(0, 0, 0)
	pcall(function()
		while FActiv do
			task.wait()
			if Torso.Parent == nil then break end
			local Speed = tonumber(FSpe.Text) or 3
			local Push = Vector3.new(0, 0, 0)
			local FV = cam.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
			local SV = cam.CFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
			local CV = CFrame.new(Vector3.new(0,0,0), cam.CFrame.LookVector*Vector3.new(1,0,1)):VectorToObjectSpace(Human.MoveDirection)

			Push = Push + ((FV * (Speed) * -CV.Z) or Push)
			Push = Push + ((SV * (Speed) * -CV.X) or Push)
			Smo = Smo:Lerp(Push, .3)

			cf = (CFrame.new(Torso.Position)*CFrame.new(Smo))*CFrame.new(Vector3.new(0,0,0), FV).Rotation
			Torso.CFrame = Torso.CFrame:Lerp(cf, .3)
		end
	end)
	ToggleFly.Text = "Flying: No"
	FActiv = false

	Human.PlatformStand = false
	Torso.Anchored = false
end

olc = nil
function FCam()
	FActiv = false
	wait()
	local cam = workspace.CurrentCamera
	local Char = lp.Character
	local Human = Char:FindFirstChildOfClass("Humanoid")
	local Torso = Char:FindFirstChild("HumanoidRootPart")

	Human.PlatformStand = true
	Torso.Anchored = true

	local Smo = Vector3.new(0, 0, 0)
	olc = Torso.CFrame
	pcall(function()
		while FCActiv do
			task.wait()
			local Speed = tonumber(FSpe.Text) or 3
			local Push = Vector3.new(0, 0, 0)
			local FV = cam.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
			local SV = cam.CFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
			local CV = CFrame.new(Vector3.new(0,0,0), cam.CFrame.LookVector*Vector3.new(1,0,1)):VectorToObjectSpace(Human.MoveDirection)

			Push = Push + ((FV * (Speed) * -CV.Z) or Push)
			Push = Push + ((SV * (Speed) * -CV.X) or Push)
			Smo = Smo:Lerp(Push, .3)

			cf = (CFrame.new(Torso.Position)*CFrame.new(Smo))*CFrame.new(Vector3.new(0,0,0), FV).Rotation
			Torso.CFrame = Torso.CFrame:Lerp(cf, .3)
		end
	end)
	Torso.CFrame = olc
	FreeCam.Text = "Freecam: No"
	FCActiv = false

	Human.PlatformStand = false
	Torso.Anchored = false
end

ToggleFly.MouseButton1Click:Connect(function()
	FActiv = not FActiv
	if FActiv then ToggleFly.Text = "Flying: Yes" Fly()
	else ToggleFly.Text = "Flying: No" end
end)

FreeCam.MouseButton1Click:Connect(function()
	FCActiv = not FCActiv
	if FCActiv then FreeCam.Text = "Freecam: Yes" FCam()
	else FreeCam.Text = "Freecam: No" end
end)

print("UUI Loaded!")