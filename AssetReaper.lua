
local TweenS = game:FindService("TweenService")
local UserInput = game:FindService("UserInputService")
local MS = game:FindService("MarketplaceService")
local Players = game:FindService("Players")

local DragModule = {
	Add = function(Object: GuiObject, UseTween: boolean)
		local dragToggle, dragStart, startPos, dragInput
		local function updateInput(input)
			local Delta = input.Position - dragStart
			local EndPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			if UseTween then
				TweenS:Create(Object, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Position = EndPos}):Play()
			else
				Object.Position = EndPos
			end
		end
		Object.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin) and UserInput:GetFocusedTextBox() == nil) then
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

		UserInput.InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
}

local Screen = Instance.new("ScreenGui")
local WindowBar = Instance.new("Frame")
local Info = Instance.new("TextBox")
local Info2 = Instance.new("Frame")
local I2_IMG,I2STRO = Instance.new("ImageLabel"),Instance.new("UIStroke")
local I2_AUD,A2PL,A2PA,A2ST,A2LE,A2SN = Instance.new("Frame"),Instance.new("TextButton"),Instance.new("TextButton"),Instance.new("TextButton"),Instance.new("TextBox"),Instance.new("Sound")
local A2POS,A2VOL,A2SPE = Instance.new("TextBox"),Instance.new("TextBox"),Instance.new("TextBox")
local Contain = Instance.new("Frame")
local _Sep = Instance.new("Frame")
local INFArrow = Instance.new("ImageButton")
local RS = Instance.new("TextButton")
local Scroll = Instance.new("ScrollingFrame")
local TemX = Instance.new("TextButton")
local _UL = Instance.new("UIListLayout")
local ScrollTemp = Instance.new("TextBox")
local Tipl = Instance.new("TextLabel")
local WinButton = Instance.new("TextButton")
local CopyBox = Instance.new("TextBox")

__pos = 2
__posR = 2
__Amount = 0
__AmountR = 0
Buttons = {}
function __NewWinBTN(Color: Color3, Size: UDim2, Text: string, Tip: string, Right: boolean)
	local Btn = WinButton:Clone()
	Btn.BackgroundColor3 = Color or Btn.BackgroundColor3
	Btn.Size = Size or Btn.Size
	Btn.Text = Text or Btn.Text

	if Tip ~= nil then
		local Tipp = Tipl:Clone()
		Tipp.Text = Tip
		Tipp.Parent = Btn
	end
	if Right then
		Btn.AnchorPoint = Vector2.new(1)
		Btn.Position = UDim2.new(1, -__posR, 0, 1)
		__AmountR += 1
		__posR = (Btn.Size.X.Offset+__posR)+2
	else
		Btn.Position = UDim2.new(0, __pos, 0, 1)
		__Amount += 1
		__pos = (Btn.Size.X.Offset+__pos)+2
	end
	table.insert(Buttons, Btn)
	Btn.Parent = WindowBar
	return Btn
end

WinButton.BackgroundTransparency = .5
WinButton.AutoButtonColor = false
WinButton.Position = UDim2.new(0,3,0,1)
WinButton.Size = UDim2.new(0,45,0,25)
WinButton.Font = Enum.Font.SourceSans
WinButton.TextColor3 = Color3.new(1,1,1)
WinButton.TextStrokeTransparency = .75
WinButton.TextSize = 14

Tipl.BackgroundTransparency = 1
Tipl.AnchorPoint = Vector2.new(.5,0)
Tipl.Position = UDim2.new(.5,0,0,-24)
Tipl.Size = UDim2.new(0,1,0,15)
Tipl.Font = Enum.Font.SourceSans
Tipl.TextColor3 = Color3.new(1,1,1)
Tipl.TextStrokeTransparency = .5
Tipl.TextSize = 14
Tipl.Name = "Tip"

ScrollTemp.BackgroundTransparency = .7
ScrollTemp.BorderSizePixel = 0
ScrollTemp.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollTemp.BorderMode = Enum.BorderMode.Inset
ScrollTemp.ClearTextOnFocus = false
ScrollTemp.TextEditable = false
ScrollTemp.TextSize = 14
ScrollTemp.TextStrokeTransparency = .75
ScrollTemp.Size = UDim2.new(1, 0, 0, 25)
ScrollTemp.Font = Enum.Font.SourceSans
ScrollTemp.TextColor3 = Color3.new(1,1,1)

TemX.Position = UDim2.new(1, 0, 0, 0)
TemX.Size = UDim2.new(0, 25, 1, 0)
TemX.AnchorPoint = Vector2.new(1, 0)
TemX.BackgroundColor3 = Color3.new(1, 0.596078, 0.596078)
TemX.BackgroundTransparency = 1
TemX.BorderSizePixel = 0
TemX.Font = Enum.Font.SourceSans
TemX.Text = "X"
TemX.Name = "x"
TemX.TextColor3 = Color3.new(0.85098, 0.443137, 0.443137)
TemX.TextSize = 18
TemX.TextStrokeTransparency = 0.75
TemX.Parent = ScrollTemp

INFArrow.Position = UDim2.new(1, 5, 0.5, 0)
INFArrow.Size = UDim2.new(0, 24, 0, 24)
INFArrow.AnchorPoint = Vector2.new(0, .5)
INFArrow.BackgroundTransparency = 1
INFArrow.AutoButtonColor = false
INFArrow.Image = "rbxasset://textures/collapsibleArrowRight.png"
INFArrow.Parent = WindowBar

Info2.Visible = false
Info2.Position = UDim2.new(1, 2, 0, 84)
Info2.Size = UDim2.new(0,100,0,100)
Info2.BackgroundTransparency=1
Info2.Parent = Contain

I2_IMG.Visible = false
I2_IMG.BackgroundTransparency=1
I2_IMG.Size = UDim2.new(1,0,1,0)
I2_IMG.Parent = Info2
I2STRO.Parent = I2_IMG

I2_AUD.Visible = false
I2_AUD.Size = UDim2.new(1,0,1,0)
I2_AUD.BackgroundTransparency = 1
I2_AUD.Parent = Info2

A2POS.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2POS.BackgroundTransparency=.5
A2POS.BorderSizePixel = 0
A2POS.Size = UDim2.new(0.32,0,0,25)
A2POS.Position = UDim2.new(0,0,0,28)
A2POS.TextSize = 14
A2POS.TextStrokeTransparency = .75
A2POS.Font = Enum.Font.SourceSans
A2POS.TextColor3 = Color3.new(1,1,1)
A2POS.Text = ""
A2POS.PlaceholderText = "Pos"
A2POS.Parent = I2_AUD

A2VOL.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2VOL.BackgroundTransparency=.5
A2VOL.BorderSizePixel = 0
A2VOL.Size = UDim2.new(0.32,0,0,25)
A2VOL.AnchorPoint=Vector2.new(.5,0)
A2VOL.Position = UDim2.new(.5,0,0,28)
A2VOL.TextSize = 14
A2VOL.TextStrokeTransparency = .75
A2VOL.Font = Enum.Font.SourceSans
A2VOL.TextColor3 = Color3.new(1,1,1)
A2VOL.Text = ""
A2VOL.PlaceholderText = "Vol"
A2VOL.Parent = I2_AUD

A2SPE.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2SPE.BackgroundTransparency=.5
A2SPE.BorderSizePixel = 0
A2SPE.Size = UDim2.new(0.32,0,0,25)
A2SPE.AnchorPoint=Vector2.new(1,0)
A2SPE.Position = UDim2.new(1,0,0,28)
A2SPE.TextSize = 14
A2SPE.TextStrokeTransparency = .75
A2SPE.Font = Enum.Font.SourceSans
A2SPE.TextColor3 = Color3.new(1,1,1)
A2SPE.Text = ""
A2SPE.PlaceholderText = "Spd"
A2SPE.Parent = I2_AUD

A2LE.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2LE.BackgroundTransparency=.5
A2LE.BorderSizePixel = 0
A2LE.AnchorPoint=Vector2.new(0,1)
A2LE.Position = UDim2.new(0,0,1,0)
A2LE.Size = UDim2.new(1,0,0,44)
A2LE.ClearTextOnFocus = false
A2LE.TextEditable = false
A2LE.TextSize = 14
A2LE.TextStrokeTransparency = .75
A2LE.Font = Enum.Font.SourceSans
A2LE.TextColor3 = Color3.new(1,1,1)
A2LE.Text = "Lenght: 123s"
A2LE.TextXAlignment = Enum.TextXAlignment.Left
A2LE.TextYAlignment = Enum.TextYAlignment.Top
A2LE.Parent = I2_AUD

A2PL.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2PL.BackgroundTransparency=.5
A2PL.BorderSizePixel = 0
A2PL.Size = UDim2.new(0.32,0,0,25)
A2PL.TextSize = 14
A2PL.TextStrokeTransparency = .75
A2PL.Font = Enum.Font.SourceSans
A2PL.TextColor3 = Color3.new(1,1,1)
A2PL.Text = "Play"
A2PL.Parent = I2_AUD

A2ST.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2ST.BackgroundTransparency=.5
A2ST.BorderSizePixel = 0
A2ST.AnchorPoint=Vector2.new(1,0)
A2ST.Position = UDim2.new(1,0,0,0)
A2ST.Size = UDim2.new(0.32,0,0,25)
A2ST.TextSize = 14
A2ST.TextStrokeTransparency = .75
A2ST.Font = Enum.Font.SourceSans
A2ST.TextColor3 = Color3.new(1,1,1)
A2ST.Text = "Stop"
A2ST.Parent = I2_AUD

A2PA.BackgroundColor3=Color3.fromRGB(70, 70, 70)
A2PA.BackgroundTransparency=.5
A2PA.BorderSizePixel = 0
A2PA.AnchorPoint=Vector2.new(0.5,0)
A2PA.Position = UDim2.new(0.5,0,0,0)
A2PA.Size = UDim2.new(0.32,0,0,25)
A2PA.TextSize = 14
A2PA.TextStrokeTransparency = .75
A2PA.Font = Enum.Font.SourceSans
A2PA.TextColor3 = Color3.new(1,1,1)
A2PA.Text = "Pause"
A2PA.Parent = I2_AUD

A2SN.Parent = I2_AUD



Screen.ResetOnSpawn = false
Screen.Name = tostring(((math.random(6668448543)+41-6*552/12)-math.random(1950101552)*7/23+94-1+51)/552*4/124+5-5125)
local s = pcall(function()Screen.Parent=game:FindService("CoreGui"):WaitForChild("RobloxGui")end)
if not s then Screen.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") end
print("AssetReaper Loading, Location:", Screen:GetFullName())

Info.Visible = false
Info.BackgroundTransparency = 1
Info.TextEditable = false
Info.ClearTextOnFocus = false
Info.Position = UDim2.new(1, 2, 0, 2)
Info.Size = UDim2.new(0, 120, 0, 80)
Info.Font = Enum.Font.SourceSans
Info.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
Info.TextStrokeTransparency = .75
Info.TextColor3 = Color3.new(1,1,1)
Info.TextSize = 14
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Text = "MSN:\nID:\nName:\nClass:\nFull Name:"
Info.PlaceholderText = "Select an object"
Info.ClipsDescendants = true
Info.Parent = Contain

WindowBar.BackgroundColor3 = Color3.fromRGB(95,95,95)
WindowBar.BorderSizePixel = 0
WindowBar.Size = UDim2.new(0, 420, 0, 30)
WindowBar.Parent = Screen

CopyBox.BackgroundColor3 = Color3.new()
CopyBox.BackgroundTransparency = 1
CopyBox.TextTransparency = 1
CopyBox.AnchorPoint = Vector2.new(0, .5)
CopyBox.Position = UDim2.new(0,0,.5,0)
CopyBox.Size = UDim2.new(1,0,0,30)
CopyBox.ClearTextOnFocus = false
CopyBox.TextEditable = false
CopyBox.Visible = false
CopyBox.TextColor3 = Color3.new(1,1,1)
CopyBox.Font = Enum.Font.SourceSans
CopyBox.Parent = Screen

Contain.BackgroundColor3 = Color3.fromRGB(109,109,109)
Contain.BorderSizePixel = 0
Contain.Position = UDim2.new(0,0,1,0)
Contain.Size = UDim2.new(1,0,0,200)
Contain.Parent = WindowBar

_Sep.AnchorPoint = Vector2.new(0, 1)
_Sep.BackgroundColor3 = Color3.new()
_Sep.BackgroundTransparency = 0.5
_Sep.BorderSizePixel = 0
_Sep.Position = UDim2.new(0,0,1,0)
_Sep.Size = UDim2.new(1,0,0,2)
_Sep.Parent = WindowBar

RS.AnchorPoint = Vector2.new(1,1)
RS.BackgroundTransparency = .5
RS.BorderMode = Enum.BorderMode.Inset
RS.Position = UDim2.new(1,0,1,0)
RS.Size = UDim2.new(0,20,0,20)
RS.ZIndex = 999
RS.Text = ""
RS.TextTransparency = 1
RS.AutoButtonColor = false
RS.Parent = Contain

_UL.Padding = UDim.new(0, 2)
_UL.VerticalAlignment = Enum.VerticalAlignment.Top
_UL.HorizontalAlignment = Enum.HorizontalAlignment.Center
_UL.FillDirection = Enum.FillDirection.Vertical
_UL.SortOrder = Enum.SortOrder.LayoutOrder
_UL.Parent = Scroll

Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.Size = UDim2.new(1,0,1,0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.CanvasSize = UDim2.new()
Scroll.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Scroll.ScrollBarThickness = 8
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.Parent = Contain



local BX = __NewWinBTN(Color3.fromRGB(255,53,53), nil, "X", nil, true)
local B_ = __NewWinBTN(nil, UDim2.new(0, 30, 0, 25), "_", nil, true)
local BST = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "Start", "Start/Stop searching")
local BW = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "What:", "What to search for?")
local BWH = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "Where:", "Where to search?")
local BMN = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "MSN:", "Get the marketplace name (slower)")
local BCL = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "Clear", "Clears found items")
local BSA = __NewWinBTN(Color3.fromRGB(0, 255, 183), nil, "Get Str", "Get string with results")

local Whatl = {
	Meshes = {
		MeshPart = {MeshId = "", TextureID = ""},
		SpecialMesh = {MeshId = "", TextureId = ""}
	},
	Images = {
		Decal = {Texture = ""},
		Texture = {Texture = ""},
		ParticleEmitter = {Texture = ""},
		ImageLabel = {Image = ""}
	},
	Clothing = {
		Shirt = {ShirtTemplate = ""},
		Pants = {PantsTemplate = ""},
		ShirtGraphic = {Graphic = ""}
	},
	Animations = {
		Animation = {AnimationId = ""}
	},
	Audio = {
		Sound = {SoundId = ""}
	}
}
local WhatN = {
	Meshes = "Mesh",
	Images = "Image",
	Clothing = "Clothing",
	Animations = "Animation",
	Audio = "Audio"
}

--Main
local Proccess = false
local Exit = false
local MSName = true
local oldsel
local Selected
local AssetList = {}
local InGuiList = {}
local For = Whatl.Animations
local In = game


function Translate()
	local tr
	for i,v in Whatl do
		if v == For then
			tr = WhatN[i]
		end
	end
	return tr
end

function GetKeys(Table: {})
	local __t = {}
	for i,v in Table do
		if i then
			table.insert(__t, i)
		end
	end
	return __t
end

function IndexDictionary(dictionary,index)
	local i = 0
	for _,value in pairs(dictionary) do
		i=i+1
		if i == index then
			return value
		end
	end
end

function RemoveOne(ID: number)
	if InGuiList[ID] then
		InGuiList[ID]:Destroy()
	end
	InGuiList[ID] = nil
	AssetList[ID] = nil
end


DragModule.Add(WindowBar, false)

function CopyBoxNew(text: string)
	if CopyBox.Visible then repeat wait(.1) until CopyBox.Visible == false end
	CopyBox.Text = text
	CopyBox.Visible = true
	TweenS:Create(CopyBox, TweenInfo.new(.2), {BackgroundTransparency = .5, TextTransparency = 0}):Play()
	CopyBox.FocusLost:Once(function(enterPressed: boolean, inputThatCausedFocusLoss: InputObject)
		TweenS:Create(CopyBox, TweenInfo.new(.2), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
		wait(.21)
		CopyBox.Visible = false
	end)
end

Info.Text = ""
local SNDC = {}
local conn
function UpdateInfo()
	if Selected then
		local Ins=AssetList[Selected][1]
		local Name=(AssetList[Selected][2] and tostring(AssetList[Selected][2]) or "Failed")
		Info.Text = ("MSN: %s\nID: %s\nName: %s\nClass: %s\nFull Name: %s"):format(Name,Selected,Ins.Name,Ins.ClassName,Ins:GetFullName())

		I2_AUD.Visible = false
		I2_IMG.Visible = false
		
		if Ins:IsA("Sound") then
			local id="rbxassetid://"..tostring(Selected)
			A2SN.SoundId = id
			repeat wait() until A2SN.IsLoaded or A2SN.SoundId~=id
			if A2SN.SoundId~=id then Info2.Visible = false return end
			for i,v in SNDC do
				v:Disconnect()
			end
			local function wpl()
				while A2SN.Playing do
					wait(.05)
					A2LE.Text = ("Length: %ss\nPosition: %ss"):format(math.floor(A2SN.TimeLength*10)/10, math.floor(A2SN.TimePosition*10)/10)
				end
			end
			A2LE.Text = ("Length: %ss\nPosition: %ss"):format(math.floor(A2SN.TimeLength*10)/10, math.floor(A2SN.TimePosition*10)/10)
			SNDC[1] = A2PL.Activated:Connect(function()
				A2SN.TimePosition = 0
				A2SN.Playing = true
				wpl()
			end)
			SNDC[2] = A2PA.Activated:Connect(function()
				A2SN.Playing = not A2SN.Playing
				wpl()
			end)
			SNDC[3] = A2ST.Activated:Connect(function()
				A2SN.TimePosition = 0
				A2SN.Playing = false
			end)
			SNDC[4] = A2POS.FocusLost:Connect(function()
				local Val = tonumber(A2POS.Text) or math.floor(A2SN.TimePosition*10)/10
				A2SN.TimePosition = Val
			end)
			SNDC[5] = A2VOL.FocusLost:Connect(function()
				local Val = tonumber(A2VOL.Text) or .5
				A2SN.Volume = Val
			end)
			SNDC[6] = A2SPE.FocusLost:Connect(function()
				local Val = tonumber(A2SPE.Text) or 1
				A2SN.PlaybackSpeed = Val
			end)
			A2SN.Changed:Connect(function(property: string)
				if property == "SoundId" then
					A2SN.TimePosition = 0
					A2SN.Playing = false
				end
			end)
			I2_AUD.Changed:Connect(function(property: string)
				if not I2_AUD.Visible then
					A2SN.TimePosition = 0
					A2SN.Playing = false
				end
			end)
			
			I2_AUD.Visible = true
			I2_IMG.Visible = false
		end
		
		local function img()
			I2_IMG.Image = "rbxassetid://"..tostring(Selected)

			I2_AUD.Visible = false
			I2_IMG.Visible = true

			if conn then
				conn:Disconnect()
			end

			conn = I2_IMG.MouseEnter:Connect(function()
				TweenS:Create(I2_IMG, TweenInfo.new(.25, Enum.EasingStyle.Cubic), {Size = UDim2.new(2.5,0,2.5,0)}):Play()
				I2_IMG.MouseLeave:Wait()
				TweenS:Create(I2_IMG, TweenInfo.new(.25, Enum.EasingStyle.Cubic), {Size = UDim2.new(1,0,1,0)}):Play()
			end)
		end
		
		for i,v in Whatl.Images do
			if Ins:IsA(i) then
				img()
			end
		end
		if Ins:IsA("Clothing") or Ins:IsA("ShirtGraphic") then
			img()
		end
	end
end

function ButtonEffect(Button: GuiButton, Duration: number)
	local tip = Button:FindFirstChild("Tip")
	TweenS:Create(Button, TweenInfo.new(Duration), {BackgroundTransparency = 1}):Play()
	if tip then TweenS:Create(tip, TweenInfo.new(Duration), {TextTransparency = 1}):Play() end
	Button.MouseEnter:Connect(function(x: number, y: number)
		TweenS:Create(Button, TweenInfo.new(Duration), {BackgroundTransparency = .5}):Play()
		if tip then TweenS:Create(tip, TweenInfo.new(Duration), {TextTransparency = 0}):Play() end
		--if Function then Function(true, x, y) end
	end)
	Button.MouseLeave:Connect(function(x: number, y: number)
		TweenS:Create(Button, TweenInfo.new(Duration), {BackgroundTransparency = 1}):Play()
		if tip then TweenS:Create(tip, TweenInfo.new(Duration), {TextTransparency = 1}):Play() end
		--if Function then Function(false, x, y) end
	end)
end

function AddToGui(ID, Inst, ValueName, order)
	local String = ("%s: %s  -  %s"):format(Translate(), ID, Inst.Name)
	if MSName or AssetList[ID][2] then
		String = ("%s: %s  -  %s (%s)"):format(Translate(), ID, (AssetList[ID][2] and tostring(AssetList[ID][2]) or "Failed"), Inst.Name)
	end
	--local String = ("%s (%s)  -  %s  -  %s  -  %s"):format(Inst.ClassName, ValueName, "Asset:"..ID, "Name:"..Inst.Name, "Market:"..(AssetList[ID][2] and tostring(AssetList[ID][2]) or "Disabled or failed"))
	if not InGuiList[ID] then
		local Template = ScrollTemp:Clone()
		Template.Text = String
		Template.LayoutOrder = IndexDictionary(Whatl, order)
		Template.Parent = Scroll
		Template.Name = ID
		Template.Focused:Connect(function()
			oldsel = Selected
			Selected = ID
			if oldsel and InGuiList[oldsel] then
				InGuiList[oldsel].BorderSizePixel = 0
			end
			Template.BorderSizePixel = 5
			UpdateInfo()
		end)
		Template.x.Activated:Connect(function()
			RemoveOne(ID)
		end)
		ButtonEffect(Template.x, .2)
		InGuiList[ID] = Template
	else
		local Obj = InGuiList[ID]
		Obj.Text = String
	end
end

function DoSearch()
	Proccess = true
	while Proccess do
		wait()
		for _,v in In:GetDescendants() do
			if not Proccess then break end
			for i2,v2 in For do
				if v:IsA(i2) and not v:IsDescendantOf(Screen) then
					for i,_ in v2 do
						local vvv = v[i] or nil
						if vvv ~= nil and not vvv:find("rbxasset://") then
							local v1 = tonumber(vvv:match("%d+"))
							if v1~=nil then
								if not AssetList[v1] then
									local s, inf = pcall(function(...) return MSName and MS:GetProductInfo(v1, Enum.InfoType.Asset) or {["Name"] = false} end)
									AssetList[v1] = {v, s and inf.Name or false}
								elseif MSName and AssetList[v1][2] == false then
									if AssetList[v1] then
										local s, inf = pcall(function(...) return MS:GetProductInfo(v1, Enum.InfoType.Asset) end)
										if AssetList[v1] then
											AssetList[v1][2] = s and inf.Name or false
										end
									end
								end
								if AssetList[v1] then
									AddToGui(v1, v, i, For)
								end
							end
						end
					end
				end
			end
		end
	end
end

function Clear()
	for _,v in InGuiList do
		v:Destroy()
	end
	AssetList = {}
	InGuiList = {}
end

function Getstr()
	local String = ""
	for i,v in InGuiList do
		String = String.."\n"..v.Text
	end
	CopyBoxNew(String)
end

table.insert(Buttons, INFArrow)
for i,v in Buttons do
	ButtonEffect(v, .2)
end

local OldSize = Contain.Size
local Exiting = false
BX.Activated:Connect(function()
	if Exit then return end
	Proccess = false
	Exit = true
	
	local MainClose = Instance.new("TextButton")
	local CLText = Instance.new("TextLabel")
	local Yes = Instance.new("TextButton")
	local No = Instance.new("TextButton")

	MainClose.AnchorPoint = Vector2.new(0.5, 0.5)
	MainClose.BackgroundColor3 = Color3.new(0, 0, 0)
	MainClose.BackgroundTransparency = 0.6
	MainClose.BorderSizePixel = 0
	MainClose.Position = UDim2.new(0.5, 0, 0.5, 10)
	MainClose.Size = UDim2.new(0, 240, 0, 140)
	MainClose.ZIndex = 3
	MainClose.AutoButtonColor = false
	MainClose.Text = ""
	MainClose.Parent = Contain

	CLText.AnchorPoint = Vector2.new(0.5, 0.5)
	CLText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CLText.BackgroundTransparency = 1
	CLText.BorderSizePixel = 0
	CLText.Position = UDim2.new(0.5, 0, 0.5, -20)
	CLText.Size = UDim2.new(0, 210, 0, 40)
	CLText.ZIndex = 4
	CLText.Font = Enum.Font.SourceSans
	CLText.Text = "Are you sure?\nYou're about to delete the gui."
	CLText.TextColor3 = Color3.new(1, 1, 1)
	CLText.TextSize = 16
	CLText.TextStrokeTransparency = 0.75
	CLText.Parent = MainClose

	Yes.AnchorPoint = Vector2.new(0.5, 0.5)
	Yes.BackgroundColor3 = Color3.fromRGB(95, 255, 87)
	Yes.BorderSizePixel = 0
	Yes.Position = UDim2.new(0.5, -45, 0.5, 20)
	Yes.Size = UDim2.new(0, 80, 0, 20)
	Yes.ZIndex = 4
	Yes.Font = Enum.Font.SourceSans
	Yes.Text = "Yes"
	Yes.TextColor3 = Color3.new(1, 1, 1)
	Yes.TextSize = 15
	Yes.TextStrokeTransparency = 0.75
	Yes.Parent = MainClose

	No.AnchorPoint = Vector2.new(0.5, 0.5)
	No.BackgroundColor3 = Color3.fromRGB(255, 62, 62)
	No.BorderSizePixel = 0
	No.Position = UDim2.new(0.5, 45, 0.5, 20)
	No.Size = UDim2.new(0, 80, 0, 20)
	No.ZIndex = 4
	No.Font = Enum.Font.SourceSans
	No.Text = "No"
	No.TextColor3 = Color3.new(1, 1, 1)
	No.TextSize = 15
	No.TextStrokeTransparency = 0.75
	No.Parent = MainClose
	
	TweenS:Create(MainClose, TweenInfo.new(.2, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	
	No.Activated:Connect(function(inputObject: InputObject, clickCount: number)
		MainClose:Destroy()
		Exit = false
	end)
	
	Yes.Activated:Connect(function(inputObject: InputObject, clickCount: number)
		Screen.Enabled = false
		wait(.2)
		Screen:Destroy()
	end)
end)

B_.Activated:Connect(function()
	Contain.Visible = not Contain.Visible
	for i,v in Buttons do
		if v~=B_ and v~=BX then
			v.Visible = Contain.Visible
			WindowBar.Size = Contain.Visible and UDim2.new(0, 420, 0, 30) or UDim2.new(0, 120, 0, 30)
		end
	end
end)


BCL.Activated:Connect(function()
	if Exit then return end
	Clear()
end)


BSA.Activated:Connect(function()
	Getstr()
end)


BST.Activated:Connect(function()
	if Exit then return end
	if Proccess then
		BST.Text = "Start"
		Proccess = false
	else
		BST.Text = "Stop"
		DoSearch()
	end
end)


BMN.Text = "MSN:\n"..(MSName and "Yes" or "No")
BMN.Activated:Connect(function()
	MSName = not MSName
	BMN.Text = "MSN:\n"..(MSName and "Yes" or "No")
end)



WhatlKeys = GetKeys(Whatl)

local n = 1
local n2 = 1
local Places = {game, workspace, game:FindService("ReplicatedStorage"), Players}
BWH.Text = "Where:\n"..Places[n].Name:sub(1, 7)
BW.Text = "What:\n"..WhatlKeys[n2]:sub(1, 6)
tip = BWH.Tip.Text
tip2 = BW.Tip.Text
BWH.Tip.Text = tip.."\n"..Places[n].Name
BW.Tip.Text = tip2.."\n"..WhatlKeys[n2]
In = Places[n]
For = IndexDictionary(Whatl, n2)

BWH.Activated:Connect(function()
	n += 1
	if n > #Places then
		n = 1
	end
	BWH.Text = "Where:\n"..Places[n].Name:sub(1, 7)
	BWH.Tip.Text = tip.."\n"..Places[n].Name
	In = Places[n]
end)


BW.Activated:Connect(function()
	n2 += 1
	if n2 > #WhatlKeys then
		n2 = 1
	end
	BW.Text = "What:\n"..WhatlKeys[n2]:sub(1, 6)
	BW.Tip.Text = tip2.."\n"..WhatlKeys[n2]
	For = IndexDictionary(Whatl, n2)
end)

invis = false
INFArrow.Activated:Connect(function(inputObject: InputObject, clickCount: number)
	invis = not invis
	TweenS:Create(INFArrow, TweenInfo.new(.2), {Rotation = invis and 180 or 0}):Play()
	Info.Visible = invis
	Info2.Visible = invis
end)

function setsize()
	local MinSize = Vector2.new(WindowBar.Size.X.Offset, 200)

	local StartSize
	local StartXY
	local Hold
	local Input
	local function updateInput(input)
		local Delta = input.Position - StartXY
		local EndSize = UDim2.new(StartSize.X.Scale, StartSize.X.Offset + Delta.X, StartSize.Y.Scale, StartSize.Y.Offset + Delta.Y)
		WindowBar.Size = UDim2.new(0, math.max(EndSize.X.Offset, MinSize.X), 0, 30)
		Contain.Size = UDim2.new(1, 0, 0, math.max(EndSize.Y.Offset, MinSize.Y))
	end
	RS.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or (input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin) and UserInput:GetFocusedTextBox() == nil) then
			Hold = true
			StartXY = input.Position
			StartSize = UDim2.new(WindowBar.Size.X.Scale, WindowBar.Size.X.Offset, Contain.Size.Y.Scale, Contain.Size.Y.Offset)
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Hold = false
				end
			end)
		end
	end)
	RS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			Input = input
		end
	end)
	UserInput.InputChanged:Connect(function(input)
		if input == Input and Hold then
			updateInput(input)
		end
	end)
end
setsize()
print("AssetReaper Loaded!")