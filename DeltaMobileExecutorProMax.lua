-- Delta Mobile Executor Pro Max
local Delta = {
    _VERSION = "7.0",
    _AUTHOR = "DeepScriptAI",
    _LICENSE = "PRIVATE - USE AT YOUR OWN RISK"
}

-- Services and configuration (previous code remains)

-- Enhanced Network Interception
Delta.Network = {
    BlockOutgoing = false,
    BlockIncoming = false,
    OriginalSend = nil,
    OriginalReceive = nil
}

function Delta.ToggleOutgoingBlock()
    Delta.Network.BlockOutgoing = not Delta.Network.BlockOutgoing
    return Delta.Network.BlockOutgoing
end

function Delta.ToggleIncomingBlock()
    Delta.Network.BlockIncoming = not Delta.Network.BlockIncoming
    return Delta.Network.BlockIncoming
end

-- Modified Manual Send to bypass blocks
function Delta.ManualSend(data)
    if Delta.Network.OriginalSend then
        return Delta.Network.OriginalSend(data)
    end
    -- Fallback implementation
end

-- Enhanced UI with new security controls
function Delta.UI.AddSecurityControls(parentFrame)
    local securityFrame = Instance.new("Frame")
    -- Frame setup and positioning
    securityFrame.Parent = parentFrame

    -- Block Outgoing Button
    local blockOutBtn = Instance.new("TextButton")
    blockOutBtn.Text = "BLOCK OUTGOING"
    -- Button setup and positioning
    blockOutBtn.Parent = securityFrame

    -- Block Incoming Button
    local blockInBtn = Instance.new("TextButton")
    blockInBtn.Text = "BLOCK INCOMING"
    -- Button setup and positioning
    blockInBtn.Parent = securityFrame

    -- Button functionality
    blockOutBtn.MouseButton1Click:Connect(function()
        local state = Delta.ToggleOutgoingBlock()
        blockOutBtn.Text = state and "ALLOW OUTGOING" or "BLOCK OUTGOING"
        blockOutBtn.BackgroundColor3 = state and Color3.fromRGB(255,50,50) or Color3.fromRGB(0,170,255)
    end)

    blockInBtn.MouseButton1Click:Connect(function()
        local state = Delta.ToggleIncomingBlock()
        blockInBtn.Text = state and "ALLOW INCOMING" or "BLOCK INCOMING"
        blockInBtn.BackgroundColor3 = state and Color3.fromRGB(255,50,50) or Color3.fromRGB(0,170,255)
    end)
end

-- Initialize with all features
local loadingScreen = Delta.UI.ShowLoadingScreen()
task.delay(3, function()
    loadingScreen.PulseTween:Cancel()
    loadingScreen.Frame:Destroy()
    local dashboard = Delta.UI.ShowMainDashboard()
    Delta.UI.AddManualSendFeature(dashboard)
    Delta.UI.AddSecurityControls(dashboard)
    Delta.UI.VerifyAllPositions() -- Ensures proper GUI alignment
end)

return Delta
