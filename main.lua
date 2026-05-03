--// GUI
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 100, 0, 40)
Button.Position = UDim2.new(0.5, -50, 0.7, 0)
Button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Button.TextColor3 = Color3.fromRGB(0, 170, 255)
Button.Text = "Lướt"
Button.TextScaled = true
Button.BorderSizePixel = 0

Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 10)

--// DRAG FIX (PC + MOBILE)
local UIS = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Button.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        
        dragging = true
        dragStart = input.Position
        startPos = Button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            update(input)
        end
    end
end)

--// LƯỚT
local player = game.Players.LocalPlayer

Button.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(999999, 0, 999999)
        bv.Velocity = hrp.CFrame.LookVector * 120
        
        bv.Parent = hrp
        game.Debris:AddItem(bv, 0.2)
    end
end)
