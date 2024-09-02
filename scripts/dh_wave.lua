local function lookAta(X, Y, Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(X, Y, Z))
end

function getClosestDemon()
    local closestDemon = nil
    local shortestDistance = math.huge
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    for _, v in next, workspace.Live:GetChildren() do
        if v:GetAttribute('Race') == "Demon" and v:FindFirstChild('Humanoid') and v:FindFirstChild('Humanoid').Health > 4 and not game.Players:FindFirstChild(v.Name) then
            local demonHRP = v:FindFirstChild("HumanoidRootPart")
            if demonHRP then
                local distance = (hrp.Position - demonHRP.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestDemon = v
                end
            end
        end
    end

    return closestDemon
end

task.spawn(function()
    while task.wait() do
        if game.Players.LocalPlayer.Backpack:FindFirstChild('Combat') then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild('Combat'))
        end
        local finalselectiondemon = getClosestDemon()
        if finalselectiondemon then
            if finalselectiondemon:FindFirstChild('Humanoid') and finalselectiondemon:FindFirstChild('Humanoid').Health > 4 then
                workspace.Camera.CameraSubject = finalselectiondemon.Humanoid
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(finalselectiondemon:GetPivot().Position + Vector3.new(1, -12, 1))
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                lookAta(finalselectiondemon:GetPivot().X, finalselectiondemon:GetPivot().Y, finalselectiondemon:GetPivot().Z)
                if game.Players.LocalPlayer.Character:FindFirstChild('Combat') then
                    game.Players.LocalPlayer.Character:FindFirstChild('Combat'):Activate()
                end
            end
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,1000,0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end
    end
end)

while task.wait() do
    for _,v in next, workspace:GetChildren() do
        if v:FindFirstChild('TouchInterest') then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            firetouchinterest(v)
            firetouchinterest(v.TouchInterest)
        end
    end
end
