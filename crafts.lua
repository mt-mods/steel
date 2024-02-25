local steel_item = xcompat.materials.steel_ingot

minetest.register_craft({
	type = "cooking",
	output = "steel:plate_hard",
	recipe = "steel:plate_soft",
})

minetest.register_craft({
	type = "cooking",
	output = "steel:grate_hard",
	recipe = "steel:grate_soft",
})

minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:strut"}}
})

minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:grate_soft"}}
})

minetest.register_craft({
	output = "steel:scrap 2",
	recipe = {{"steel:grate_hard"}}
})

minetest.register_craft({
	output = "steel:scrap",
	recipe = {{"steel:roofing"}}
})

minetest.register_craft({
	output = "steel:scrap 4",
	recipe = {{"steel:plate_soft"}}
})

minetest.register_craft({
	output = "steel:scrap 4",
	recipe = {{"steel:plate_hard"}}
})

if minetest.get_modpath("default") then
	minetest.register_craft({
		output = "steel:plate_soft 2",
		recipe = {
			{steel_item, steel_item},
			{steel_item, steel_item},
		}
	})

	minetest.register_craft({
		output = "steel:grate_soft 3",
		recipe = {
			{steel_item, "", steel_item},
			{steel_item, "", steel_item},
		}
	})

	minetest.register_craft({
		output = "steel:roofing 6",
		recipe = {{steel_item, steel_item, steel_item}}
	})

	minetest.register_craft({
		output = "steel:strut_mount",
		recipe = {{"steel:strut", steel_item}}
	})

	minetest.register_craft({
		output = "steel:strut_mount",
		recipe = {{"streets:steel_support", steel_item}}
	})

	minetest.register_craft({
		output = "default:iron_lump",
		recipe = {{"steel:scrap", "steel:scrap"}}
	})
end

if not minetest.get_modpath("streets") or not minetest.get_modpath("steelsupport") then
	minetest.register_craft({
		output = "steel:strut 5",
		recipe = {
			{"", steel_item, ""},
			{steel_item, steel_item, steel_item},
			{"", steel_item, ""},
		}
	})
end