local BrotherUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/gryehrur/BrotherUI/refs/heads/main/BrotherLib/Main/base/scripts/library.lua"))() -- Brother Library by snw1w

-- Custom colors
local customColors = {
    Primary = Color3.fromRGB(20, 0, 20),
    Secondary = Color3.fromRGB(30, 0, 30),
    Accent = Color3.fromRGB(50, 0, 50),
    Text = Color3.fromRGB(255, 255, 255),
    Element = Color3.fromRGB(40, 0, 40),
    Glow = Color3.fromRGB(80, 0, 80)
}
local Window = BrotherUI.CreateLib("Brother Exploit", "Default", customColors)

-- Main Tab
local MainTab = Window:NewTab("Main")
MainTab:NewButton("Click Me", function()
    print("Button clicked!")
end)
MainTab:NewToggle("Speed Hack", function(state)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
end)
MainTab:NewSlider("Walk Speed", 16, 100, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

-- RIG Tab
local RigTab = Window:NewTab("RIG")
RigTab:NewButton("Rig Button", function()
    print("Rig Button clicked!")
end)
RigTab:NewToggle("Rig Toggle", function(state)
    print("Rig Toggle state: " .. tostring(state))
end)
RigTab:NewSlider("Rig Slider", 0, 50, function(value)
    print("Rig Slider value: " .. value)
end)
