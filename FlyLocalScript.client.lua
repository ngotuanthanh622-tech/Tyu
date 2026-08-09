-- LocalScript trong StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Cấu hình
local flyKey = Enum.KeyCode.E
local flySpeed = 50
local isFlying = false

local bodyVelocity = nil
local bodyGyro = nil
local renderConnection = nil

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    isFlying = false
end)

local function startFlying()
    isFlying = true
    humanoid.PlatformStand = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1000000
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = rootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1000000
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = rootPart

    renderConnection = RunService.RenderStepped:Connect(function()
        if not isFlying or not rootPart then return end

        local camera = workspace.CurrentCamera
        local moveVector = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector += camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector -= camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector -= camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector += camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector += Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector -= Vector3.new(0, 1, 0)
        end

        if moveVector.Magnitude > 0 then
            bodyVelocity.Velocity = moveVector.Unit * flySpeed
        else
            bodyVelocity.Velocity = Vector3.zero
        end

        bodyGyro.CFrame = camera.CFrame
    end)
end

local function stopFlying()
    isFlying = false
    humanoid.PlatformStand = false

    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end

    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end

    if renderConnection then
        renderConnection:Disconnect()
        renderConnection = nil
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == flyKey then
        if isFlying then
            stopFlying()
        else
            startFlying()
        end
    end
end)
