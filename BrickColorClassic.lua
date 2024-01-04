local OLD_COLORS = {
	BrickColor.new("White"); BrickColor.new("Medium blue"); BrickColor.new("Light reddish violet"); BrickColor.new("Sand green"); 
	BrickColor.new("Dark orange"); BrickColor.new("Light stone grey"); BrickColor.new("Brick yellow"); BrickColor.new("Brown"); 
	BrickColor.new("Dark stone grey"); BrickColor.new("Light orange"); BrickColor.new("Dark green"); BrickColor.new("Medium red"); 
	BrickColor.new("Reddish brown"); BrickColor.new("Nougat"); BrickColor.new("Sand blue"); BrickColor.new("Medium stone grey"); 
	BrickColor.new("Medium green"); BrickColor.new("Bright yellow"); BrickColor.new("Bright orange"); BrickColor.new("Pastel Blue"); 
	BrickColor.new("Bright green"); BrickColor.new("Bright bluish green"); BrickColor.new("Light blue"); BrickColor.new("Br. yellowish green"); 
	BrickColor.new("Bright blue"); BrickColor.new("Br. yellowish orange"); BrickColor.new("Black"); BrickColor.new("Sand red"); 
	BrickColor.new("Earth green"); BrickColor.new("Bright violet"); BrickColor.new("Bright red"); BrickColor.new("Cool yellow"); 
}

------------------------------------------------------------------------------ 

local BrickColorClassic = {}

-- BrickColor.Random(), but for classic colors.
-- BrickColorClassic.Random()
local R = Random.new()
function BrickColorClassic.Random()
	return OLD_COLORS[R:NextInteger(1, #OLD_COLORS)]
end

-- Convert color to a classic color.
-- BrickColorClassic.Convert(Color3)
function BrickColorClassic.Convert(color : Color3)
	local pickedColor
	local value = math.huge
	
	-- Euclidean Color Difference
	for _, brickColor in pairs(OLD_COLORS) do
		local bc3 = brickColor.Color
		local r, g, b = (color.R - bc3.R), (color.G - bc3.G), (color.B - bc3.B)
		local currentVal = math.sqrt(r^2 + g^2 + b^2)
		if currentVal < value then
			value = currentVal
			pickedColor = brickColor
		end
	end
	
	return pickedColor
end

return BrickColorClassic
