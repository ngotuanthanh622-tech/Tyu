-- F3X MINI - Roblox Studio
-- Đặt Script này vào ServerScriptService

local Players = game:GetService("Players")

local selected = {}

local function makePart(player)
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local part = Instance.new("Part")
    part.Name = "F3X_Block"
    part.Size = Vector3.new(4, 4, 4)
    part.Position = root.Position + root.CFrame.LookVector * 8
    part.Anchored = true
    part.Parent = workspace
    return part
end

local function createGUI(player)
    local gui = Instance.new("ScreenGui")
    gui.Name = "F3XMini"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(220, 330)
    frame.Position = UDim2.fromOffset(20, 100)
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "F3X MINI"
    title.TextScaled = true
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.Parent = frame

    local function button(text, y, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(1, -20, 0, 40)
        b.Position = UDim2.fromOffset(10, y)
        b.Text = text
        b.TextScaled = true
        b.Parent = frame
        b.MouseButton1Click:Connect(callback)
    end

    button("Create", 50, function()
        local part = makePart(player)
        selected[player] = part
    end)

    button("Move +X", 95, function()
        local p = selected[player]
        if p then p.Position += Vector3.new(2, 0, 0) end
    end)

    button("Move +Y", 140, function()
        local p = selected[player]
        if p then p.Position += Vector3.new(0, 2, 0) end
    end)

    button("Move +Z", 185, function()
        local p = selected[player]
        if p then p.Position += Vector3.new(0, 0, 2) end
    end)

    button("Resize", 230, function()
        local p = selected[player]
        if p then p.Size += Vector3.new(1, 1, 1) end
    end)

    button("Rotate", 275, function()
        local p = selected[player]
        if p then
            p.CFrame *= CFrame.Angles(0, math.rad(15), 0)
        end
    end)
end

Players.PlayerAdded:Connect(function(player)
    createGUI(player)
end)
