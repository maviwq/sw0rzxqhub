local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")

--- LOADING EKRANI ---
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingGui"
loadingGui.Parent = player.PlayerGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 300, 0, 80)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -40)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadingFrame.BackgroundTransparency = 0.3
loadingFrame.Parent = loadingGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 12)
loadingCorner.Parent = loadingFrame

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, 0, 0.5, 0)
loadingText.Position = UDim2.new(0, 0, 0.1, 0)
loadingText.Text = "Yükleniyor..."
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 16
loadingText.BackgroundTransparency = 1
loadingText.Parent = loadingFrame

-- Yüklenme çubuğu
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 0, 10)
progressBar.Position = UDim2.new(0.05, 0, 0.7, 0)
progressBar.AnchorPoint = Vector2.new(0, 0.5)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.Parent = loadingFrame

local progressBarCorner = Instance.new("UICorner")
progressBarCorner.CornerRadius = UDim.new(0, 5)
progressBarCorner.Parent = progressBar

local progressBarBackground = Instance.new("Frame")
progressBarBackground.Name = "ProgressBarBackground"
progressBarBackground.Size = UDim2.new(0.9, 0, 0, 10)
progressBarBackground.Position = UDim2.new(0.05, 0, 0.7, 0)
progressBarBackground.AnchorPoint = Vector2.new(0, 0.5)
progressBarBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
progressBarBackground.Parent = loadingFrame

local progressBarBackgroundCorner = Instance.new("UICorner")
progressBarBackgroundCorner.CornerRadius = UDim.new(0, 5)
progressBarBackgroundCorner.Parent = progressBarBackground

--- ANİMASYONLU MESAJ SİSTEMİ ---
local function showMessage(text)
    local color = Color3.fromRGB(40, 40, 40) -- Koyu gri arkaplan
    
    local messageGui = Instance.new("ScreenGui")
    messageGui.Name = "MessageGui"
    messageGui.Parent = player.PlayerGui

    local messageFrame = Instance.new("Frame")
    messageFrame.Size = UDim2.new(0, 0, 0, 40)
    messageFrame.Position = UDim2.new(0, 10, 0.5, -20)
    messageFrame.BackgroundColor3 = color
    messageFrame.BackgroundTransparency = 0.3
    messageFrame.AnchorPoint = Vector2.new(0, 0.5)
    messageFrame.Parent = messageGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = messageFrame

    local messageText = Instance.new("TextLabel")
    messageText.Size = UDim2.new(1, -20, 1, -10)
    messageText.Position = UDim2.new(0, 10, 0, 5)
    messageText.Text = " "..text.." "
    messageText.TextColor3 = Color3.fromRGB(255, 255, 255)
    messageText.Font = Enum.Font.GothamBold
    messageText.TextSize = 14
    messageText.BackgroundTransparency = 1
    messageText.TextXAlignment = Enum.TextXAlignment.Left
    messageText.Parent = messageFrame

    -- Animasyonla açılma
    local openTween = tweenService:Create(
        messageFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, messageText.TextBounds.X + 40, 0, 40)}
    )
    openTween:Play()

    -- 3 saniye sonra animasyonla kapanma
    delay(2.7, function()
        local closeTween = tweenService:Create(
            messageFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 40)}
        )
        closeTween:Play()
        closeTween.Completed:Connect(function()
            messageGui:Destroy()
        end)
    end)
end

--- HOŞGELDİN MESAJI ---
local function showWelcomeMessage()
    local welcomeGui = Instance.new("ScreenGui")
    welcomeGui.Name = "WelcomeGui"
    welcomeGui.Parent = player.PlayerGui

    local welcomeFrame = Instance.new("Frame")
    welcomeFrame.Size = UDim2.new(0, 0, 0, 60)
    welcomeFrame.Position = UDim2.new(0.5, 0, 0.5, -30)
    welcomeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    welcomeFrame.BackgroundTransparency = 1
    welcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    welcomeFrame.Parent = welcomeGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = welcomeFrame

    local welcomeText = Instance.new("TextLabel")
    welcomeText.Size = UDim2.new(1, 0, 1, 0)
    welcomeText.Position = UDim2.new(0, 0, 0, 0)
    welcomeText.Text = "Hoşgeldiniz!"
    welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.TextSize = 24
    welcomeText.BackgroundTransparency = 1
    welcomeText.Parent = welcomeFrame

    -- Giriş animasyonu
    local fadeIn = tweenService:Create(
        welcomeFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.3}
    )
    fadeIn:Play()

    -- 2 saniye bekleyip çıkış animasyonu
    delay(2, function()
        local fadeOut = tweenService:Create(
            welcomeFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        )
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            welcomeGui:Destroy()
        end)
    end)
end

--- ANA ARAYÜZ ---
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedMenu"
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

--- BAŞLIK ÇUBUĞU ---
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0.15, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Sw0rzxqHub"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.Parent = titleBar

--- KONTROL BUTONLARI ---
local controlButtons = Instance.new("Frame")
controlButtons.Name = "ControlButtons"
controlButtons.Size = UDim2.new(0, 60, 0, 30)
controlButtons.Position = UDim2.new(1, -60, 0, 0)
controlButtons.BackgroundTransparency = 1
controlButtons.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(0, 0, 0, 0)
minimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 14
minimizeButton.Parent = controlButtons

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = controlButtons

--- AÇ BUTONU ---
local openButton = Instance.new("TextButton")
openButton.Name = "OpenButton"
openButton.Size = UDim2.new(0, 120, 0, 40)
openButton.Position = UDim2.new(1, -130, 1, -50)
openButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openButton.Text = "Menüyü Aç"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14
openButton.Visible = false
openButton.Parent = screenGui

local openButtonCorner = Instance.new("UICorner")
openButtonCorner.CornerRadius = UDim.new(0, 12)
openButtonCorner.Parent = openButton

--- BUTON PANELİ ---
local buttonPanel = Instance.new("Frame")
buttonPanel.Name = "ButtonPanel"
buttonPanel.Size = UDim2.new(0, 120, 1, -30)
buttonPanel.Position = UDim2.new(0, 0, 0, 30)
buttonPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
buttonPanel.Parent = mainFrame

local buttonPanelCorner = Instance.new("UICorner")
buttonPanelCorner.CornerRadius = UDim.new(0, 12)
buttonPanelCorner.Parent = buttonPanel

--- OYUNCU BUTONU ---
local playerButton = Instance.new("TextButton")
playerButton.Name = "PlayerButton"
playerButton.Size = UDim2.new(0.9, 0, 0, 40)
playerButton.Position = UDim2.new(0.05, 0, 0, 10)
playerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
playerButton.Text = "Oyuncu"
playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
playerButton.Font = Enum.Font.GothamBold
playerButton.TextSize = 14
playerButton.Parent = buttonPanel

local playerButtonCorner = Instance.new("UICorner")
playerButtonCorner.CornerRadius = UDim.new(0, 8)
playerButtonCorner.Parent = playerButton

--- TROLL BUTONU ---
local trollButton = Instance.new("TextButton")
trollButton.Name = "TrollButton"
trollButton.Size = UDim2.new(0.9, 0, 0, 40)
trollButton.Position = UDim2.new(0.05, 0, 0, 60)
trollButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
trollButton.Text = "Troll"
trollButton.TextColor3 = Color3.fromRGB(255, 255, 255)
trollButton.Font = Enum.Font.GothamBold
trollButton.TextSize = 14
trollButton.Parent = buttonPanel

local trollButtonCorner = Instance.new("UICorner")
trollButtonCorner.CornerRadius = UDim.new(0, 8)
trollButtonCorner.Parent = trollButton

--- İÇERİK PANELİ ---
local contentPanel = Instance.new("Frame")
contentPanel.Name = "ContentPanel"
contentPanel.Size = UDim2.new(1, -130, 1, -40)
contentPanel.Position = UDim2.new(0, 125, 0, 35)
contentPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentPanel.Parent = mainFrame

local contentPanelCorner = Instance.new("UICorner")
contentPanelCorner.CornerRadius = UDim.new(0, 12)
contentPanelCorner.Parent = contentPanel

--- OYUNCU İÇERİĞİ ---
local playerContent = Instance.new("Frame")
playerContent.Name = "PlayerContent"
playerContent.Size = UDim2.new(1, 0, 1, 0)
playerContent.BackgroundTransparency = 1
playerContent.Visible = true
playerContent.Parent = contentPanel

--- FLY SİSTEMİ ---
local flying = false
local bodyGyro = nil
local bodyVelocity = nil
local flySpeed = 50
local walkSpeed = 16

local flyButton = Instance.new("TextButton")
flyButton.Name = "FlyButton"
flyButton.Size = UDim2.new(0.9, 0, 0, 50)
flyButton.Position = UDim2.new(0.05, 0, 0.05, 0)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flyButton.Text = "FLY"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.GothamBold
flyButton.TextSize = 16
flyButton.Parent = playerContent

local flyButtonCorner = Instance.new("UICorner")
flyButtonCorner.CornerRadius = UDim.new(0, 8)
flyButtonCorner.Parent = flyButton

--- HIZ AYARLARI ---
local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Name = "FlySpeedLabel"
flySpeedLabel.Size = UDim2.new(0.4, 0, 0, 25)
flySpeedLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Hızı:"
flySpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedLabel.Font = Enum.Font.GothamBold
flySpeedLabel.TextSize = 14
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = playerContent

local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Name = "FlySpeedBox"
flySpeedBox.Size = UDim2.new(0.5, 0, 0, 30)
flySpeedBox.Position = UDim2.new(0.45, 0, 0.2, 0)
flySpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
flySpeedBox.Text = "50"
flySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedBox.Font = Enum.Font.Gotham
flySpeedBox.TextSize = 14
flySpeedBox.Parent = playerContent

local flySpeedBoxCorner = Instance.new("UICorner")
flySpeedBoxCorner.CornerRadius = UDim.new(0, 6)
flySpeedBoxCorner.Parent = flySpeedBox

local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Name = "WalkSpeedLabel"
walkSpeedLabel.Size = UDim2.new(0.4, 0, 0, 25)
walkSpeedLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "Yürüme Hızı:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.Font = Enum.Font.GothamBold
walkSpeedLabel.TextSize = 14
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.Parent = playerContent

local walkSpeedBox = Instance.new("TextBox")
walkSpeedBox.Name = "WalkSpeedBox"
walkSpeedBox.Size = UDim2.new(0.5, 0, 0, 30)
walkSpeedBox.Position = UDim2.new(0.45, 0, 0.3, 0)
walkSpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
walkSpeedBox.Text = "16"
walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedBox.Font = Enum.Font.Gotham
walkSpeedBox.TextSize = 14
walkSpeedBox.Parent = playerContent

local walkSpeedBoxCorner = Instance.new("UICorner")
walkSpeedBoxCorner.CornerRadius = UDim.new(0, 6)
walkSpeedBoxCorner.Parent = walkSpeedBox

--- TROLL İÇERİĞİ ---
local trollContent = Instance.new("Frame")
trollContent.Name = "TrollContent"
trollContent.Size = UDim2.new(1, 0, 1, 0)
trollContent.BackgroundTransparency = 1
trollContent.Visible = false
trollContent.Parent = contentPanel

--- IŞINLANMA SİSTEMİ ---
local function findPlayer(name)
    name = name:lower()
    for _, target in ipairs(game:GetService("Players"):GetPlayers()) do
        if target ~= player and 
           (target.Name:lower():find(name) or 
           (target.DisplayName and target.DisplayName:lower():find(name))) then
            return target
        end
    end
    return nil
end

local function teleportToPlayer(targetName)
    local success, errorMsg = pcall(function()
        local target = findPlayer(targetName)
        if not target then
            showMessage("Oyuncu bulunamadı")
            return false
        end
        
        local targetChar = target.Character
        if not targetChar then
            showMessage("Karakter yüklü değil")
            return false
        end
        
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            showMessage("Hedef rootpart yok")
            return false
        end
        
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
        
        delay(0.1, function()
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end)
        
        showMessage("Işınlanma Gerçekleşti")
        return true
    end)
    
    if not success then
        showMessage("Işınlanma Hatası")
        warn("Işınlanma Hatası:", errorMsg)
        return false
    end
end

--- TROLL MENÜSÜNE IŞINLANMA ELEMANLARI ---
local teleportBox = Instance.new("TextBox")
teleportBox.Name = "TeleportBox"
teleportBox.Size = UDim2.new(0.7, 0, 0, 30)
teleportBox.Position = UDim2.new(0.1, 0, 0.4, 0)
teleportBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
teleportBox.PlaceholderText = "Oyuncu adı/takma ad"
teleportBox.Text = ""
teleportBox.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBox.Font = Enum.Font.Gotham
teleportBox.TextSize = 14
teleportBox.Parent = trollContent

local teleportBoxCorner = Instance.new("UICorner")
teleportBoxCorner.CornerRadius = UDim.new(0, 6)
teleportBoxCorner.Parent = teleportBox

local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(0.7, 0, 0, 40)
teleportButton.Position = UDim2.new(0.1, 0, 0.5, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
teleportButton.Text = "IŞINLAN"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 16
teleportButton.Parent = trollContent

local teleportButtonCorner = Instance.new("UICorner")
teleportButtonCorner.CornerRadius = UDim.new(0, 8)
teleportButtonCorner.Parent = teleportButton

--- IŞINLANMA BUTON BAĞLANTISI ---
teleportButton.MouseButton1Click:Connect(function()
    local targetName = teleportBox.Text
    if targetName == "" then return end
    
    local success = pcall(function()
        teleportToPlayer(targetName)
    end)
    
    if not success then
        teleportButton.Text = "HATA!"
        task.wait(1)
        teleportButton.Text = "IŞINLAN"
    end
end)

--- CHAT KOMUTU EKLEME ---
local function onChatMessage(message)
    if message:sub(1, 1) ~= ";" then return end
    
    local command = message:sub(2):lower()
    
    if command == "fly" then
        enableFly()
    elseif command == "unfly" then
        disableFly()
    elseif command:find("to ") then
        local targetName = command:sub(4)
        teleportToPlayer(targetName)
    end
end

player.Chatted:Connect(onChatMessage)

--- FLY FONKSİYONLARI ---
local function updateFly()
    if not flying or not bodyVelocity or not bodyGyro then return end
    
    local direction = Vector3.new(0, 0, 0)
    local camera = workspace.CurrentCamera
    local cameraCFrame = camera.CFrame
    
    if userInputService:IsKeyDown(Enum.KeyCode.W) then
        direction = direction + cameraCFrame.LookVector
    end
    if userInputService:IsKeyDown(Enum.KeyCode.S) then
        direction = direction - cameraCFrame.LookVector
    end
    if userInputService:IsKeyDown(Enum.KeyCode.A) then
        direction = direction - cameraCFrame.RightVector
    end
    if userInputService:IsKeyDown(Enum.KeyCode.D) then
        direction = direction + cameraCFrame.RightVector
    end
    if userInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction = direction + Vector3.new(0, 1, 0)
    end
    if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        direction = direction + Vector3.new(0, -1, 0)
    end
    
    if direction.Magnitude > 0 then
        direction = direction.Unit * flySpeed
    end
    
    bodyVelocity.Velocity = direction
    bodyGyro.CFrame = cameraCFrame
end

local function enableFly()
    if flying then return end
    
    flying = true
    flyButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 10000
    bodyGyro.maxTorque = Vector3.new(20e5, 20e5, 20e5)
    bodyGyro.cframe = workspace.CurrentCamera.CFrame
    bodyGyro.Parent = rootPart
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(20e5, 20e5, 20e5)
    bodyVelocity.Parent = rootPart
    
    humanoid.PlatformStand = true
    runService.Heartbeat:Connect(updateFly)
    
    showMessage("Fly aktif")
end

local function disableFly()
    if not flying then return end
    
    flying = false
    flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
    
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
    humanoid.PlatformStand = false
    
    showMessage("Fly deaktif")
end

--- ANİMASYON FONKSİYONLARI ---
local function tweenOpen()
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 10, 0, 10)
    mainFrame.Position = UDim2.new(0.5, -5, 0.5, -5)
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local sizeTween = tweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 500, 0, 400)})
    local positionTween = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -250, 0.5, -200)})
    
    sizeTween:Play()
    positionTween:Play()
end

local function tweenClose(callback)
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    local sizeTween = tweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 10, 0, 10)})
    local positionTween = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -5, 0.5, -5)})
    
    sizeTween:Play()
    positionTween:Play()
    sizeTween.Completed:Connect(function()
        mainFrame.Visible = false
        if callback then callback() end
    end)
end

local function tweenMinimize()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local sizeTween = tweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 100, 0, 30)})
    local positionTween = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(1, -110, 1, -40)})
    
    sizeTween:Play()
    positionTween:Play()
    sizeTween.Completed:Connect(function()
        openButton.Visible = true
    end)
end

local function tweenRestore()
    openButton.Visible = false
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local sizeTween = tweenService:Create(mainFrame, tweenInfo, {Size = UDim2.new(0, 500, 0, 400)})
    local positionTween = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -250, 0.5, -200)})
    
    sizeTween:Play()
    positionTween:Play()
end

--- BUTON BAĞLANTILARI ---
flyButton.MouseButton1Click:Connect(function()
    if flying then disableFly() else enableFly() end
end)

flySpeedBox.FocusLost:Connect(function()
    local newSpeed = tonumber(flySpeedBox.Text)
    if newSpeed and newSpeed >= 50 and newSpeed <= 500 then
        flySpeed = newSpeed
    else
        flySpeedBox.Text = tostring(flySpeed)
    end
end)

walkSpeedBox.FocusLost:Connect(function()
    local newSpeed = tonumber(walkSpeedBox.Text)
    if newSpeed and newSpeed >= 16 and newSpeed <= 500 then
        walkSpeed = newSpeed
        humanoid.WalkSpeed = walkSpeed
    else
        walkSpeedBox.Text = tostring(walkSpeed)
    end
end)

minimizeButton.MouseButton1Click:Connect(tweenMinimize)
closeButton.MouseButton1Click:Connect(function()
    tweenClose(function() screenGui:Destroy() end)
end)
openButton.MouseButton1Click:Connect(tweenRestore)

playerButton.MouseButton1Click:Connect(function()
    playerContent.Visible = true
    trollContent.Visible = false
end)

trollButton.MouseButton1Click:Connect(function()
    playerContent.Visible = false
    trollContent.Visible = true
end)

--- KARAKTER TAKİP ---
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = walkSpeed
    disableFly()
end)

--- LOADING EKRANINI KAPAT VE HOŞGELDİN MESAJI GÖSTER ---
-- Yüklenme çubuğu animasyonu
for i = 1, 100 do
    progressBar.Size = UDim2.new(0, (i/100) * (progressBarBackground.AbsoluteSize.X), 0, 10)
    wait(0.02)
end

-- Loading ekranını kapat
local fadeTween = tweenService:Create(loadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
local textTween = tweenService:Create(loadingText, TweenInfo.new(0.5), {TextTransparency = 1})
local progressTween = tweenService:Create(progressBar, TweenInfo.new(0.5), {BackgroundTransparency = 1})
local progressBgTween = tweenService:Create(progressBarBackground, TweenInfo.new(0.5), {BackgroundTransparency = 1})

fadeTween:Play()
textTween:Play()
progressTween:Play()
progressBgTween:Play()

fadeTween.Completed:Connect(function()
    loadingGui:Destroy()
    tweenOpen()
    showWelcomeMessage()
end)

--- BAŞLANGIÇ AYARLARI ---
humanoid.WalkSpeed = walkSpeed
