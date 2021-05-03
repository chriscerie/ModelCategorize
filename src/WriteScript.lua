local ReplicatedStorage = game:GetService("ReplicatedStorage")

local src = script.Parent
local Serial = require(src.Serial)

local WriteScript = {}

function WriteScript:Write(categories: table)
    local module = Instance.new("ModuleScript")
    module.Name = "ModelCategorize"

    module.Source = Serial:Serialize(categories)

    module.Parent = ReplicatedStorage
end

return WriteScript