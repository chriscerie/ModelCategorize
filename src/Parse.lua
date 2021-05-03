local src = script.Parent
local WriteScript = require(src.WriteScript)

local Parse = {}

function Parse:StartParse(model: Model)
    local categories = {}

    for _,part in pairs(model:GetChildren()) do
        for k,v in pairs(part:GetAttributes()) do
            if k == "Category" then
                categories[v] = categories[v] and categories[v] + 1 or 1

                part.Name = v .. categories[v]
            end
        end
    end

    -- Reformat table
    for k,v in pairs(categories) do
        local parts = {}
        for i=1,v do
            table.insert(parts, k .. i)
        end
        categories[k] = parts
    end

    WriteScript:Write(categories)
end

return Parse