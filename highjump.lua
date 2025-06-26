<meta name='viewport' content='width=device-width, initial-scale=1'/>local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local function setup()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")

    -- High smooth velocity boost
    local jumpVelocity = 120  -- Higher value = higher jump
    local airBoost = false

    -- Anti-cheat kick prevention
    pcall(function()
        settings().Physics.AllowSleep = false
    end)

    -- Detect when jump input is triggered
    humanoid.StateChanged:Connect(function(oldState, newState)
        if newState == Enum.HumanoidStateType.Jumping and not airBoost then
            airBoost = true
            RunService.RenderStepped:Wait()
            rootPart.Velocity = Vector3.new(0, jumpVelocity, 0)
            wait(0.3)
            airBoost = false
        end
    end)
end

-- Handle character respawn
player.CharacterAdded:Connect(function()
    task.wait(1)
    setup()
end)

-- Initial setup
setup()