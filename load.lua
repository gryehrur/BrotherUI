local BrotherUI = {} -- Brother Library by snw1w

local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Утилиты для анимаций
local Utility = {}
function Utility:Tween(obj, properties, duration)
    tweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), properties):Play()
end

-- Темы (ещё темнее)
local themes = {
    Default = {
        Primary = Color3.fromRGB(10, 10, 10),      -- Основной фон (почти чёрный)
        Secondary = Color3.fromRGB(15, 15, 15),    -- Вторичный фон (чуть светлее)
        Accent = Color3.fromRGB(35, 35, 35),       -- Акцентный цвет (тёмно-серый)
        Text = Color3.fromRGB(180, 180, 180),      -- Цвет текста (мягкий серый)
        Element = Color3.fromRGB(25, 25, 25),      -- Элементы UI (очень тёмный)
        Glow = Color3.fromRGB(50, 50, 50)          -- Цвет свечения для эффектов
    }
}

-- Перетаскивание окна с анимацией
function BrotherUI:EnableDragging(frame, parent, headerColor)
    local dragging, dragInput, mousePos, framePos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            Utility:Tween(frame, {BackgroundColor3 = frame.BackgroundColor3:Lerp(Color3.new(1, 1, 1), 0.1)}, 0.2)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            -- Используем переданный цвет заголовка напрямую
            local targetColor = headerColor or themes.Default.Accent
            Utility:Tween(frame, {BackgroundColor3 = targetColor}, 0.2)
        end
    end)
end

-- Создание библиотеки
function BrotherUI.CreateLib(title, themeName, customColors)
    local theme = themes[themeName] or themes.Default
    if customColors then -- Пользовательские цвета
        theme = {
            Primary = customColors.Primary or theme.Primary,
            Secondary = customColors.Secondary or theme.Secondary,
            Accent = customColors.Accent or theme.Accent,
            Text = customColors.Text or theme.Text,
            Element = customColors.Element or theme.Element,
            Glow = customColors.Glow or theme.Glow
        }
    end
    local guiName = "BrotherUI_" .. tostring(math.random(1, 1000)) -- Brother Library GUI by snw1w

    -- Главный контейнер
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = guiName
    screenGui.Parent = game.CoreGui
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 550, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    mainFrame.BackgroundColor3 = theme.Primary
    mainFrame.Parent = screenGui
    mainFrame.BackgroundTransparency = 1
    local mainCorner = Instance.new("UICorner", mainFrame)
    mainCorner.CornerRadius = UDim.new(0, 10)
    local mainStroke = Instance.new("UIStroke", mainFrame)
    mainStroke.Color = theme.Glow
    mainStroke.Thickness = 1
    Utility:Tween(mainFrame, {BackgroundTransparency = 0}, 0.6)

    -- Заголовок
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundColor3 = theme.Accent
    header.Parent = mainFrame
    local headerColor = header.BackgroundColor3 -- Сохраняем цвет заголовка
    local headerCorner = Instance.new("UICorner", header)
    headerCorner.CornerRadius = UDim.new(0, 10)
    local headerStroke = Instance.new("UIStroke", header)
    headerStroke.Color = theme.Glow
    headerStroke.Thickness = 1
    -- Передаём цвет заголовка напрямую в EnableDragging
    BrotherUI:EnableDragging(header, mainFrame, headerColor)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = theme.Text
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    -- Кнопка минимизации
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    minimizeBtn.Position = UDim2.new(1, -60, 0, 5)
    minimizeBtn.BackgroundColor3 = theme.Element
    minimizeBtn.Text = "-"
    minimizeBtn.TextColor3 = theme.Text
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 16
    minimizeBtn.Parent = header
    local minCorner = Instance.new("UICorner", minimizeBtn)
    minCorner.CornerRadius = UDim.new(0, 6)

    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = theme.Element
    closeBtn.Text = "X"
    closeBtn.TextColor3 = theme.Text
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.Parent = header
    local closeCorner = Instance.new("UICorner", closeBtn)
    closeCorner.CornerRadius = UDim.new(0, 6)

    -- Контейнер контента
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -35)
    contentFrame.Position = UDim2.new(0, 0, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    -- Панель вкладок
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(0, 160, 1, 0)
    tabFrame.BackgroundColor3 = theme.Secondary
    tabFrame.Parent = contentFrame
    local tabCorner = Instance.new("UICorner", tabFrame)
    tabCorner.CornerRadius = UDim.new(0, 8)
    local tabList = Instance.new("UIListLayout", tabFrame)
    tabList.Padding = UDim.new(0, 8)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder

    -- Контейнер страниц
    local pageFrame = Instance.new("Frame")
    pageFrame.Size = UDim2.new(1, -160, 1, 0)
    pageFrame.Position = UDim2.new(0, 160, 0, 0)
    pageFrame.BackgroundTransparency = 1
    pageFrame.Parent = contentFrame
    local pages = Instance.new("Folder", pageFrame)

    -- Логика минимизации
    local minimized = false
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Utility:Tween(mainFrame, {Size = UDim2.new(0, 550, 0, 35)}, 0.4)
            contentFrame.Visible = false
            minimizeBtn.Text = "+"
        else
            Utility:Tween(mainFrame, {Size = UDim2.new(0, 550, 0, 400)}, 0.4)
            contentFrame.Visible = true
            minimizeBtn.Text = "-"
        end
    end)
    minimizeBtn.MouseEnter:Connect(function() Utility:Tween(minimizeBtn, {BackgroundColor3 = theme.Glow}, 0.2) end)
    minimizeBtn.MouseLeave:Connect(function() Utility:Tween(minimizeBtn, {BackgroundColor3 = theme.Element}, 0.2) end)
    closeBtn.MouseButton1Click:Connect(function()
        Utility:Tween(mainFrame, {BackgroundTransparency = 1}, 0.4)
        wait(0.4)
        screenGui:Destroy()
    end)
    closeBtn.MouseEnter:Connect(function() Utility:Tween(closeBtn, {BackgroundColor3 = Color3.fromRGB(100, 0, 0)}, 0.2) end)
    closeBtn.MouseLeave:Connect(function() Utility:Tween(closeBtn, {BackgroundColor3 = theme.Element}, 0.2) end)

    local Tabs = {}
    local firstTab = true

    function Tabs:NewTab(tabName)
        if not tabName then return end -- Проверка на nil
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, -10, 0, 35)
        tabBtn.Position = UDim2.new(0, 5, 0, 0)
        tabBtn.BackgroundColor3 = theme.Element
        tabBtn.Text = tabName
        tabBtn.TextColor3 = theme.Text
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 16
        tabBtn.Parent = tabFrame
        local tabCorner = Instance.new("UICorner", tabBtn)
        tabCorner.CornerRadius = UDim.new(0, 8)
        local tabStroke = Instance.new("UIStroke", tabBtn)
        tabStroke.Color = theme.Glow
        tabStroke.Thickness = 1

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 5
        page.ScrollBarImageColor3 = theme.Glow
        page.Parent = pages
        page.CanvasPosition = Vector2.new(0, 0)
        local pageList = Instance.new("UIListLayout", page)
        pageList.Padding = UDim.new(0, 8)
        pageList.SortOrder = Enum.SortOrder.LayoutOrder

        local function updateSize()
            page.CanvasSize = UDim2.new(0, 0, 0, pageList.AbsoluteContentSize.Y)
        end
        page.ChildAdded:Connect(updateSize)
        page.ChildRemoved:Connect(updateSize)

        if firstTab then
            page.Visible = true
            tabBtn.BackgroundColor3 = theme.Accent
            firstTab = false
        else
            page.Visible = false
        end

        tabBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages:GetChildren()) do 
                if p ~= page then Utility:Tween(p, {CanvasPosition = Vector2.new(0, 0)}, 0.2) end
                p.Visible = false 
            end
            for _, t in pairs(tabFrame:GetChildren()) do
                if t:IsA("TextButton") then Utility:Tween(t, {BackgroundColor3 = theme.Element}, 0.2) end
            end
            page.Visible = true
            Utility:Tween(tabBtn, {BackgroundColor3 = theme.Accent}, 0.2)
            updateSize()
        end)
        tabBtn.MouseEnter:Connect(function() 
            if tabBtn.BackgroundColor3 ~= theme.Accent then 
                Utility:Tween(tabBtn, {BackgroundColor3 = theme.Glow}, 0.2) 
            end 
        end)
        tabBtn.MouseLeave:Connect(function() 
            if tabBtn.BackgroundColor3 ~= theme.Accent then 
                Utility:Tween(tabBtn, {BackgroundColor3 = theme.Element}, 0.2) 
            end 
        end)

        local Elements = {}

        function Elements:NewButton(text, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Position = UDim2.new(0, 5, 0, 0)
            btn.BackgroundColor3 = theme.Element
            btn.Text = text
            btn.TextColor3 = theme.Text
            btn.Font = Enum.Font.GothamSemibold
            btn.TextSize = 16
            btn.Parent = page
            local btnCorner = Instance.new("UICorner", btn)
            btnCorner.CornerRadius = UDim.new(0, 8)
            local btnStroke = Instance.new("UIStroke", btn)
            btnStroke.Color = theme.Glow
            btnStroke.Thickness = 1

            btn.MouseButton1Click:Connect(callback or function() end)
            btn.MouseEnter:Connect(function() Utility:Tween(btn, {BackgroundColor3 = theme.Glow}, 0.2) end)
            btn.MouseLeave:Connect(function() Utility:Tween(btn, {BackgroundColor3 = theme.Element}, 0.2) end)
            btn.MouseButton1Down:Connect(function() Utility:Tween(btn, {Size = UDim2.new(1, -10, 0, 33)}, 0.1) end)
            btn.MouseButton1Up:Connect(function() Utility:Tween(btn, {Size = UDim2.new(1, -10, 0, 35)}, 0.1) end)
            updateSize()
        end

        function Elements:NewToggle(text, callback)
            local toggled = false
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(1, -10, 0, 35)
            toggle.BackgroundColor3 = theme.Element
            toggle.Text = text .. " [OFF]"
            toggle.TextColor3 = theme.Text
            toggle.Font = Enum.Font.GothamSemibold
            toggle.TextSize = 16
            toggle.Parent = page
            local togCorner = Instance.new("UICorner", toggle)
            togCorner.CornerRadius = UDim.new(0, 8)
            local togStroke = Instance.new("UIStroke", toggle)
            togStroke.Color = theme.Glow
            togStroke.Thickness = 1

            toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                toggle.Text = text .. (toggled and " [ON]" or " [OFF]")
                Utility:Tween(toggle, {BackgroundColor3 = toggled and theme.Accent or theme.Element}, 0.2)
                callback(toggled)
            end)
            toggle.MouseEnter:Connect(function() if not toggled then Utility:Tween(toggle, {BackgroundColor3 = theme.Glow}, 0.2) end end)
            toggle.MouseLeave:Connect(function() if not toggled then Utility:Tween(toggle, {BackgroundColor3 = theme.Element}, 0.2) end end)
            updateSize()
        end

        function Elements:NewSlider(text, min, max, callback)
            local slider = Instance.new("Frame")
            slider.Size = UDim2.new(1, -10, 0, 45)
            slider.BackgroundColor3 = theme.Element
            slider.Parent = page
            local sliderCorner = Instance.new("UICorner", slider)
            sliderCorner.CornerRadius = UDim.new(0, 8)
            local sliderStroke = Instance.new("UIStroke", slider)
            sliderStroke.Color = theme.Glow
            sliderStroke.Thickness = 1

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 0, 20)
            label.BackgroundTransparency = 1
            label.Text = text .. ": " .. min
            label.TextColor3 = theme.Text
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 16
            label.Parent = slider

            local sliderBar = Instance.new("Frame")
            sliderBar.Size = UDim2.new(1, -20, 0, 8)
            sliderBar.Position = UDim2.new(0, 10, 0, 30)
            sliderBar.BackgroundColor3 = theme.Secondary
            sliderBar.Parent = slider
            local barCorner = Instance.new("UICorner", sliderBar)
            barCorner.CornerRadius = UDim.new(0, 6)

            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = theme.Glow
            fill.Parent = sliderBar
            local fillCorner = Instance.new("UICorner", fill)
            fillCorner.CornerRadius = UDim.new(0, 6)

            local dragging
            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    Utility:Tween(sliderBar, {BackgroundColor3 = theme.Glow}, 0.2)
                end
            end)
            userInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                    Utility:Tween(sliderBar, {BackgroundColor3 = theme.Secondary}, 0.2)
                end
            end)
            runService.RenderStepped:Connect(function()
                if dragging then
                    local mouse = userInputService:GetMouseLocation()
                    local relativeX = math.clamp((mouse.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    Utility:Tween(fill, {Size = UDim2.new(relativeX, 0, 1, 0)}, 0.1)
                    local value = min + (max - min) * relativeX
                    label.Text = text .. ": " .. math.floor(value)
                    callback(math.floor(value))
                end
            end)
            updateSize()
        end

        return Elements
    end

    -- Проверка на корректность возврата
    if not Tabs then
        error("Failed to initialize Tabs in BrotherUI.CreateLib")
    end
    return Tabs
end

return BrotherUI -- Brother Library by snw1w
