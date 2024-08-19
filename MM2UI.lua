
local UIS = game:FindService("UserInputService")
local Plrs = game:FindService("Players")
local Plr = Plrs.LocalPlayer

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

local conn = {}

local ScreenGui = Instance.new("ScreenGui")
local Win = Instance.new("TextButton")
local x = Instance.new("TextButton")
local Main = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local UIPadding = Instance.new("UIPadding")
local hid = Instance.new("TextButton")

ScreenGui.Name = tostring(((math.random(916532933)+512-42*53/914)-math.random(109271252)*194/2421+14-3331+228)/491*99/1+4-32125)
ScreenGui.ResetOnSpawn = false
local s = pcall(function()ScreenGui.Parent=game:FindService("CoreGui")end)
if not s then ScreenGui.Parent = Plr:WaitForChild("PlayerGui") end

Win.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
Win.BorderSizePixel = 0
Win.Size = UDim2.new(0, 400, 0, 30)
Win.AutoButtonColor = false
Win.Font = Enum.Font.RobotoMono
Win.Text = "MM2 UI"
Win.TextColor3 = Color3.new(1,1,1)
Win.TextSize = 16
Win.TextStrokeTransparency = 0
Win.Parent = ScreenGui

DragModule.Add(Win)

x.AnchorPoint = Vector2.new(1, 0)
x.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
x.BorderSizePixel = 0
x.Position = UDim2.new(1, 0, 0, 0)
x.Size = UDim2.new(0, 30, 0, 30)
x.Font = Enum.Font.SourceSans
x.Text = "X"
x.TextColor3 = Color3.fromRGB(255, 69, 69)
x.TextSize = 16
x.TextStrokeTransparency = 0.75
x.Parent = Win

Main.Active = true
Main.BackgroundColor3 = Color3.fromRGB(102, 102, 102)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 0, 1, 0)
Main.Size = UDim2.new(1, 0, 0, 110)
Main.CanvasSize = UDim2.new(0, 0, 0, 0)
Main.Parent = Win

UIPadding.PaddingTop = UDim.new(0, 5)
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.Parent = Main

UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
UIGridLayout.CellSize = UDim2.new(0, 100, 0, 30)
UIGridLayout.Parent = Main

hid.AnchorPoint = Vector2.new(1, 0)
hid.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
hid.BorderSizePixel = 0
hid.Position = UDim2.new(1, -30, 0, 0)
hid.Size = UDim2.new(0, 30, 0, 30)
hid.Font = Enum.Font.SourceSans
hid.Text = "_"
hid.TextColor3 = Color3.new(1,1,1)
hid.TextSize = 16
hid.TextStrokeTransparency = 0.75
hid.Parent = Win

local plrs = Plrs
local plr = plrs.LocalPlayer

function NewBTN(txt)
	local TextButton = Instance.new("TextButton")
	TextButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	TextButton.BorderColor3 = Color3.new(0,0,0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(0, 200, 0, 50)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = txt
	TextButton.TextColor3 = Color3.new(1,1,1)
	TextButton.TextSize = 14
	TextButton.TextStrokeTransparency = 0.75
	TextButton.Parent = Main
	return TextButton
end

function notif(str,dur,tit)
	game:FindService("StarterGui"):SetCore("SendNotification", {
		Title = tit or "MM2 UI",
		Text = str,
		Duration = dur or 5
	})
end

function Murd()
	for i, v in plrs:GetPlayers() do
		if v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife")) then
			return v
		end
	end
end

function Sher()
	for i, v in plrs:GetPlayers() do
		if v.Backpack:FindFirstChild("Gun") or (v.Character and v.Character:FindFirstChild("Gun")) then
			return v
		end
	end
end

x.MouseButton1Click:Connect(function()
	Esp = false
	NotifGun = false
	ScreenGui.Enabled = false
	for i,v in conn do
		v:Disconnect()
	end
	wait(3)
	ScreenGui:Destroy()
end)

hid.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
	Win.Size = Main.Visible and UDim2.new(0, 400, 0, 30) or UDim2.new(0, 120, 0, 30)
end)

NewBTN("Find Murd & Sher").MouseButton1Click:Connect(function()
	local m = Murd()
	local s = Sher()
	notif((s~=nil and s.Name.." is sheriff.\n" or "Sheriff not found.\n")..(m~=nil and m.Name.."is murderer." or "Murderer not found."))
end)

--[[NewBTN("TP to Lobby").MouseButton1Click:Connect(function()
	pcall(function(...)
		plr.Character.HumanoidRootPart.CFrame = workspace.Lobby.Spawns.Spawn.CFrame
	end)
end)]]

--[[NewBTN("Kill All (Murderer)").MouseButton1Click:Connect(function()
	for i, v in game:FindService("Players"):GetChildren() do
		if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
		Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
		local args = {
			[1] = "Slash"
		}

		Plr.Character.Knife:WaitForChild("Stab"):FireServer(unpack(args))
		task.wait(.25)
	end
end)]]

NewBTN("Unfreeze all").MouseButton1Click:Connect(function()
	for i, v in Plrs:GetChildren() do
		if v ~= Plr and not v.Backpack:FindFirstChild("Knife") and v.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
			task.wait(.75)
		end
	end
end)

NewBTN("Grab Gun").MouseButton1Click:Connect(function()
	if workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("GunDrop") then
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local p = plr.Character.HumanoidRootPart.CFrame
			plr.Character.HumanoidRootPart.CFrame = workspace.Normal.GunDrop.CFrame
			wait(.5)
			plr.Character.HumanoidRootPart.CFrame = p
		else
			notif("Character not found.")
		end
	else
		notif("Gun not found.")
	end
end)

NewBTN("TP to Murderer").MouseButton1Click:Connect(function()
	local m = Murd()
	if m and m.Character and m.Character:FindFirstChild("HumanoidRootPart") then
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			plr.Character.HumanoidRootPart.CFrame = m.Character.HumanoidRootPart.CFrame
		end
	else
		notif("Murderer not found.")
	end
end)

NewBTN("TP to Sheriff").MouseButton1Click:Connect(function()
	local s = Sher()
	if s and s.Character and s.Character:FindFirstChild("HumanoidRootPart") then
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			plr.Character.HumanoidRootPart.CFrame = s.Character.HumanoidRootPart.CFrame
		end
	else
		notif("Sherrif not found.")
	end
end)

NewBTN("Rejoin").MouseButton1Click:Connect(function()
	game:FindService('TeleportService'):Teleport(game.PlaceId, plr)
end)

NotifGun = false
local ng = NewBTN("Notify Gun: No")
local con = {}
ng.MouseButton1Click:Connect(function()
	NotifGun = not NotifGun
	ng.Text = NotifGun and "Notify Gun: Yes" or "Notify Gun: No"
end)

Esp = false
local eps = NewBTN("ESP: No")

local Hl = Instance.new("Highlight")
Hl.FillTransparency = .5

eps.MouseButton1Click:Connect(function()
	Esp = not Esp
	eps.Text = Esp and "ESP: Yes" or "ESP: No"
	if Esp then
		local MeS = Hl:Clone()
		local SeS = Hl:Clone()
		local GeS = Hl:Clone()
		SeS.FillColor = Color3.new(0, 0.333333, 1)
		GeS.FillColor = Color3.new(0, 0.666667, 0)

		MeS.Parent = workspace.CurrentCamera
		SeS.Parent = workspace.CurrentCamera
		GeS.Parent = workspace.CurrentCamera
		
		while Esp do
			local m = Murd()
			local s = Sher()
			
			if m and plr~=m and m.Character then
				MeS.Adornee = m.Character
			else
				MeS.Adornee = nil
			end
			
			if s and plr~=s and s.Character then
				SeS.Adornee = s.Character
			else
				SeS.Adornee = nil
			end
			
			if workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("GunDrop") then
				GeS.Adornee = workspace.Normal.GunDrop
			else
				GeS.Adornee = nil
			end
			
			wait(2)
		end
		MeS:Destroy()
		SeS:Destroy()
		GeS:Destroy()
	end
end)

NewBTN("God").MouseButton1Click:Connect(function()
	if Murd()~=Plr and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
		local ol = Plr.Character.HumanoidRootPart.CFrame
		Plr.Character:WaitForChild("Humanoid").Health = 0
		Plr.CharacterAdded:Wait()
		Plr.Character:WaitForChild("HumanoidRootPart").CFrame = ol
	end
end)

c1 = workspace.DescendantAdded:Connect(function(child)
	if child.Name == "GunDrop" and child.Parent.Name == "Normal" and NotifGun then
		notif("Gun was dropped!", 4, "✅ Gun ✅")
	end
end)
c2 = workspace.DescendantRemoving:Connect(function(child)
	if child.Name == "GunDrop" and child.Parent.Name == "Normal" and NotifGun then
		notif("Gun was taken!", 4, "❌ Gun ❌")
	end
end)
table.insert(conn, c1)
table.insert(conn, c2)

print("MM2 UI Loaded!")