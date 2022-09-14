local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

test_object = {
	author = "flux",
	license = "AGPL_v3",
	version = {year = 2022, month = 9, day = 14},
	fork = "flux",

	modname = modname,
	modpath = modpath,
	S = S,
}

minetest.register_entity("test_object:object", {
	initial_properties = {
		physical = false,
		collide_with_objects = false,
		pointable = false,
		visual = "cube",
	},

	get_staticdata = function(self)
		return self.color
	end,

	on_activate = function(self, color)
		self.color = color
		local texture = ("[combine:16x16^[noalpha^[colorize:%s:255"):format(color)
		self.object:set_properties({textures = {texture, texture, texture, texture, texture, texture}})
	end
})

local function get_color(p1, pos, p2)
	local red = math.round(255 * (pos.x - p1.x) / (p2.x - p1.x + 1))
	local green = math.round(255 * (pos.z - p1.z) / (p2.z - p1.z + 1))
	return ("#%02x%02x00"):format(red, green)
end

minetest.register_chatcommand("create_field", {
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local radius = tonumber(param)

		if not (player and radius) then
			return false, "usage: /create_field <radius>"
		end

		local center = vector.round(player:get_pos())
		local p1 = vector.subtract(center, vector.new(radius, 0, radius))
		local p2 = vector.add(center, vector.new(radius, 0, radius))

		for pos in futil.iterate_area(p1, p2) do
			if pos.x % 2 == 0 and pos.z % 2 == 0 then
				minetest.add_entity(pos, "test_object:object", get_color(p1, pos, p2))
			end
		end
	end
})
