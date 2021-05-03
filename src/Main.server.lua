local src = script.parent
local Roact = require(src.Parent.vendor.Roact)
local App = require(src.UI.App)

local e = Roact.createElement
local open = false

local toolbar = plugin:CreateToolbar("ModelCategorize")
local pluginButton = toolbar:CreateButton("Categorize Model", "Categorize Model", "rbxassetid://6061165944")

-- Create Widget
local widget = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,  -- Widget will be initialized in floating panel
	false,  -- Widget will be initially enabled
	true,  	-- Don't override the previous enabled state
	520,    -- Default width of the floating window
	340,    -- Default height of the floating window
	150,    -- Minimum width of the floating window (optional)
	150     -- Minimum height of the floating window (optional)
)

-- Create new widget GUI
local mainWidget = plugin:CreateDockWidgetPluginGui("MainWidget", widget)

Roact.mount(e(App), mainWidget, "ModelCategorize")

local function onPluginButtonClicked()
	open = not open
	mainWidget.Enabled = open and true or false
end

-- Bind X button
mainWidget:BindToClose(function()
	open = false
	mainWidget.Enabled = false
end)

pluginButton.Click:Connect(onPluginButtonClicked)