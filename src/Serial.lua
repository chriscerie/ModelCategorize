-- By Tiffblocks

local Serial = {}

local function SerializeValue(categories, depth)
    local ty = typeof(categories)
	local indent = ("  "):rep(depth)

	local str
	if ty == 'number' or ty == 'boolean' then
		str = tostring(categories)
	elseif ty == 'string' then
		str = string.format("%q", categories)
	elseif ty == 'table' and #categories > 0 then
		-- array
		str = { "{" }

		for i = 1, #categories do
			str[#str+1] = string.format("%s  %s,", indent, SerializeValue(categories[i], depth + 1))
		end

		str[#str+1] = indent.."}"
	elseif ty == 'table' then
		-- dict
		str = { "{" }

		local ident = "^([%a_][%w_]*)$"
		local keys = {}
		for key, value in pairs(categories) do
			keys[#keys+1] = key
		end
		table.sort(keys)
		for i = 1, #keys do
			local key = keys[i]
			local value = categories[key]
			local safeKey
			if typeof(key) == 'string' and key:match(ident) then
				safeKey = key
			else
				safeKey = Serial.SerializeValue(key, depth + 1)
			end
			str[#str+1] = string.format("%s  %s = %s,", indent, safeKey, SerializeValue(value, depth + 1))
		end

		str[#str+1] = indent.."}"
	else
		error("Unexpected type: "..ty)
	end

	if typeof(str) == 'table' then
		str = table.concat(str, '\n')
	end
	return str
end

function Serial:Serialize(categories: table)
    return "return " .. SerializeValue(categories, 0)
end

return Serial