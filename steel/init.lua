dofile(minetest.get_modpath("steel").."/rust.lua")

minetest.register_node("steel:plate_soft", {
	description = "Soft steel plate",
	tile_images = {"steelplatesoft.png"},
	is_ground_content = true,
	groups = {cracky=2},
})

minetest.register_node("steel:plate_hard", {
	description = "Hardened steel plate",
	tile_images = {"steelplatehard.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("steel:plate_rusted", {
	description = "Rusted steel plate",
	tile_images = {"steel_rusted.png"},
	is_ground_content = true,
	groups = {cracky=1,choppy=1},
})

minetest.register_node("steel:strut", {
	drawtype = "glasslike",
	description = "Strut",
	tile_images = {"strut.png"},
	is_ground_content = true,
	paramtype= "light",
	groups = {choppy=1,cracky=1},
	sounds =  default.node_sound_stone_defaults(),
})
minetest.register_node("steel:grate_soft", {
	description = "Soft Steel Grate",
	drawtype = "fencelike",
	tile_images = {"worldgratesoft.png"},
	inventory_image = "gratesoft.png",
	wield_image = "gratesoft.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=2,choppy=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("steel:grate_hard", {
	description = "Hardened Steel Grate",
	drawtype = "fencelike",
	tile_images = {"worldgratehard.png"},
	inventory_image = "gratehard.png",
	wield_image = "gratehard.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=1,choppy=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("steel:roofing", {
	description = "Corrugated steel roofing",
	drawtype = "raillike",
	tile_images = {"corrugated_steel.png", "corrugated_steel.png", "corrugated_steel.png", "corrugated_steel.png"},
	inventory_image = "corrugated_steel.png",
	wield_image = "corrugated_steel.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
})

	--steel scrap are only used to recover ingots

minetest.register_craftitem("steel:scrap", {
	description = "Steel scraps",
	inventory_image = "scrap.png",
})

	--recipes

minetest.register_craft({
	output = 'steel:plate_soft 2',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot'},
	}
})



minetest.register_craft({
	type = "cooking",
	output = "steel:plate_hard",
	recipe = "steel:plate_soft",
})


minetest.register_craft({
	output = 'steel:grate_soft 3',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "steel:grate_hard",
	recipe = "steel:grate_soft",
})

minetest.register_craft({
	output = 'steel:strut 5',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'steel:roofing 6',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
	--remelting recipes

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:strut'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:grate_soft'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 2',
	recipe = {
		{'steel:grate_hard'},
	}
})

minetest.register_craft({
	output = 'steel:scrap',
	recipe = {
		{'steel:roofing'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 4',
	recipe = {
		{'steel:plate_soft'},
	}
})

minetest.register_craft({
	output = 'steel:scrap 4',
	recipe = {
		{'steel:plate_hard'},
	}
})

minetest.register_craft({
	output = 'default:iron_lump',
	recipe = {
		{'steel:scrap', 'steel:scrap'},
	}
})




