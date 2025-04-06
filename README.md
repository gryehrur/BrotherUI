#BrotherUI - Roblox Exploit GUI Library
BrotherUI is a simple and powerful library for creating graphical user interfaces (GUIs) for Roblox exploits. It provides easy-to-use tools for building windows, tabs, and controls like buttons, toggles, and sliders, with smooth animations and customizable color themes.
Author: snw1w

#Features
Easy window creation with tabbed navigation.

Support for buttons, toggles, and sliders.

Smooth animations using TweenService.

Draggable window functionality.

Minimize and close buttons.

Customizable color themes.

Seamless integration into any Roblox exploit.

#Installation
To use BrotherUI, add the following code at the start of your script. It loads the library from the official GitHub repository:
lua

local BrotherUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/gryehrur/BrotherUI/refs/heads/main/BrotherLib/Main/base/scripts/library.lua"))() -- Brother Library by snw1w

Ensure your exploit supports game:HttpGet for fetching external code.
#Usage
#1. Creating a Window
Start by creating a window using the CreateLib function. You can specify the window title, theme, and custom colors (optional).
lua

-- Custom colors (optional)
local customColors = {
    Primary = Color3.fromRGB(20, 0, 20),   -- Dark purple background
    Secondary = Color3.fromRGB(30, 0, 30), -- Secondary background
    Accent = Color3.fromRGB(50, 0, 50),    -- Accent color
    Text = Color3.fromRGB(255, 255, 255),  -- White text
    Element = Color3.fromRGB(40, 0, 40),   -- UI elements
    Glow = Color3.fromRGB(80, 0, 80)       -- Glow effect
}

-- Create the window
local Window = BrotherUI.CreateLib("Brother Exploit", "Default", customColors)

title (string): The window title (displayed in the header).

themeName (string): Theme name (defaults to "Default").

customColors (table, optional): A table with custom colors to override the default theme.

If customColors is omitted, the "Default" theme is used.
#2. Adding Tabs
Create a tab using the NewTab method. Each tab serves as a container for UI elements.
lua

local Tab = Window:NewTab("Main")

tabName (string): The tab’s name, shown in the sidebar.

#3. Adding UI Elements
The tab returns an Elements object, which you can use to add buttons, toggles, and sliders.
Button (NewButton)
Creates a button that executes a function when clicked.
lua

Tab:NewButton("Click Me", function()
    print("Button clicked!")
end)

text (string): Text displayed on the button.

callback (function): Function executed when the button is clicked.

#Toggle (NewToggle)
Creates an on/off toggle switch with a state.
lua

Tab:NewToggle("Speed Hack", function(state)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state and 50 or 16
end)

text (string): Text next to the toggle.

callback (function): Function that takes state (boolean) — true (on) or false (off).

#Slider (NewSlider)
Creates a slider for selecting a value within a range.
lua

Tab:NewSlider("Walk Speed", 16, 100, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

text (string): Text above the slider.

min (number): Minimum value.

max (number): Maximum value.

callback (function): Function that takes value (number) — the current slider value.

#Full Example
Here’s an example of creating a window with multiple tabs and elements:
lua

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

#Additional Features
Draggable Window: Click and hold the header to move the window.

Minimize: Click the - button in the header to collapse the window (changes to +).

Close: Click the X button to close the GUI with a fade-out animation.

#Themes
The default theme is "Default". You can customize it by passing a customColors table with these keys:
Primary: Main window background.

Secondary: Tab panel and slider background.

Accent: Color for active elements (tabs, toggles).

Text: Text color.

Element: Color for inactive elements (buttons, toggles).

Glow: Border and hover effect color.

#Dependencies
The library uses built-in Roblox services:
TweenService for animations.

UserInputService for input handling.

RunService for slider functionality.

#Notes
Ensure your exploit supports Lua script execution and access to game.CoreGui.

The source code of BrotherUI is encrypted and closed-source. Modification, reverse-engineering, or redistribution of the library is strictly prohibited.

Using exploits violates Roblox’s Terms of Service and may result in account bans. Use at your own risk.

#License
This project is closed-source and proprietary. You may use the library as provided via the official link, but you are not permitted to modify, decompile, or redistribute it in any form.

#Credits
Author: snw1w.

Thanks to the Roblox community for inspiration and testing.

If you have questions or encounter issues, feel free to open an issue on GitHub!

