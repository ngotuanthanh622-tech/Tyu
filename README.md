-- Đặt trong LocalScript (ví dụ: StarterPlayerScripts)
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Giả sử bạn có một RemoteEvent tên là "SkillEvent" trong ReplicatedStorage để báo cho Server
local skillEvent = ReplicatedStorage:WaitForChild("SkillEvent")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    -- Bấm phím Z để tung chiêu 1
    if input.KeyCode == Enum.KeyCode.Z then
        print("Client: Kích hoạt chiêu Z!")
        skillEvent:FireServer("Skill_Z")
    end
end)
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera

local function shakeCamera(intensity, duration)
    local startTime = os.clock()
    while os.clock() - startTime < duration do
        local x = math.random(-intensity, intensity) / 100
        local y = math.random(-intensity, intensity) / 100
        local z = math.random(-intensity, intensity) / 100
        camera.CFrame = camera.CFrame * CFrame.new(x, y, z)
        task.wait()
    end
end
-- Gọi hàm: shakeCamera(5, 0.2) khi nhân vật tung chiêu trúng 
