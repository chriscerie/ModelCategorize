local Selection = game:GetService("Selection")

local src = script.parent.parent
local Roact = require(src.Parent.vendor.Roact)
local Parse = require(src.Parse)

local e = Roact.createElement

local App = Roact.Component:extend("App")

function App:render()
    return e("Frame", {
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.fromRGB(52,52,52),
    }, {
        StartButton = e("TextButton", {
            AnchorPoint = Vector2.new(0.5,0.5),
            BackgroundColor3 = Color3.fromRGB(78,170,255),
            Position = UDim2.fromScale(0.5,0.5),
            Size = UDim2.fromScale(0.6,0.2),
            Font = Enum.Font.SourceSansBold,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255,255,255),
            Text = "Start",

            [Roact.Event.Activated] = function()
                for _,v in pairs(Selection:Get()) do
                    if v:IsA("Model") then
                        Parse:StartParse(v)
                    end
                end
            end
        }, {
            UICorner = e("UICorner", {
                CornerRadius = UDim.new(0.2,0),
            })
        })
    })
end

return App