std = "lua51+luajit+minetest+test_object"
unused_args = false
max_line_length = 120

stds.minetest = {
	read_globals = {
		"DIR_DELIM",
		"minetest",
		"core",
		"dump",
		"vector",
		"nodeupdate",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		"table",
		"math",
		"string",
	}
}

stds.test_object = {
	globals = {
		"test_object",
	},
	read_globals = {
		"futil",
	},
}
