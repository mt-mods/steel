local sound_api = xcompat.sounds

-- Item
minetest.register_craftitem("steel:scrap", {
	description = "Steel scrap",
	inventory_image = "steel_scrap.png",
})

-- Nodes
minetest.register_node("steel:plate_soft", {
	description = "Soft steel plate",
	tiles = {"steel_plate_soft.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 2, dig_stone = 1},
	is_ground_content = false,
})

minetest.register_node("steel:plate_hard", {
	description = "Hardened steel plate",
	tiles = {"steel_plate_hard.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 1, dig_stone = 1},
	is_ground_content = false,
})

minetest.register_node("steel:plate_rusted", {
	description = "Rusted steel plate",
	tiles = {"steel_plate_rusted.png"},
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {cracky = 1, choppy = 1, dig_stone = 1},
	is_ground_content = false,
})

minetest.register_node("steel:grate_soft", {
	description = "Soft Steel Grate",
	drawtype = "fencelike",
	tiles = {"steel_grate_soft.png"},
	inventory_image = "steel_grate_soft_inventory.png",
	wield_image = "steel_grate_soft_inventory.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	sounds = sound_api.node_sound_wood_defaults(),
	groups = {cracky = 2, choppy = 2, dig_stone = 1},
	is_ground_content = false,
})

minetest.register_node("steel:grate_hard", {
	description = "Hardened Steel Grate",
	drawtype = "fencelike",
	tiles = {"steel_grate_hard.png"},
	inventory_image = "steel_grate_hard_inventory.png",
	wield_image = "steel_grate_hard_inventory.png",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	sounds = sound_api.node_sound_wood_defaults(),
	groups = {cracky = 1, choppy = 1, dig_stone = 1},
	is_ground_content = false,
})

minetest.register_node("steel:roofing", {
	description = "Corrugated steel roofing",
	drawtype = "raillike",
	tiles = {"steel_corrugated_steel.png"},
	inventory_image = "steel_corrugated_steel.png",
	wield_image = "steel_corrugated_steel.png",
	paramtype = "light",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, dig_generic = 1},
	is_ground_content = false,
})

-- Depreciated, kept around for legacy world compat
minetest.register_node("steel:roofing_wall", {
	description = "Corrugated steel wall",
	drawtype = "nodebox",
	tiles = {"steel_corrugated_steel.png"},
	inventory_image = "steel_corrugated_steel.png",
	wield_image = "steel_corrugated_steel.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	drop = "steel:roofing",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.48, 0.5, 0.5, -0.48 }
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, -0.4 }
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, not_in_creative_inventory = 1, dig_generic = 1},
	is_ground_content = false,
})

if minetest.get_modpath("homedecor_roofing") then
	homedecor_roofing.register_slope("steel", "roofing",
		"steel:roofing",
		{snappy = 1, dig_immediate = 2},
		{"steel_corrugated_steel.png" },
		"Corrugated steel roofing"
	)

	homedecor_roofing.register_roof("steel", "roofing",
		{snappy = 1, dig_immediate = 2},
		{"steel_corrugated_steel.png" },
		"Corrugated steel roofing"
	)
end

local base_tex = "steel_strut.png"

if minetest.get_modpath("streets") or minetest.get_modpath("steelsupport") then
	minetest.register_alias("steel:strut", "streets:steel_support")
	base_tex = "streets_support.png"
else
	minetest.register_node("steel:strut", {
		drawtype = "glasslike",
		description = "Strut",
		tiles = {base_tex},
		use_texture_alpha = "clip",
		paramtype = "light",
		sounds =  sound_api.node_sound_stone_defaults(),
		groups = {choppy = 1, cracky = 1, dig_stone = 1},
		is_ground_content = false,
	})
	minetest.register_alias("streets:steel_support", "steel:strut")
end

minetest.register_node("steel:strut_mount", {
	description = "Strut with mount",
	drawtype = "mesh",
	mesh = "steel_cube.obj",
	tiles = {
		base_tex,
		base_tex,
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
		base_tex.."^steel_strut_overlay.png",
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sounds = sound_api.node_sound_stone_defaults(),
	groups = {choppy = 1, cracky = 1, dig_stone = 1},
	is_ground_content = false,
})

if minetest.get_modpath("unifieddyes") and minetest.get_modpath("default") then
	minetest.register_node("steel:steel_block", {
		description = "Steel block (colorized)",
		tiles = {"steel_default_steel_block.png"},
		paramtype = "light",
		paramtype2 = "color",
		is_ground_content = false,
		palette = "unifieddyes_palette_extended.png",
		on_construct = unifieddyes.on_construct,
		sounds = sound_api.node_sound_metal_defaults(),
		on_dig = unifieddyes.on_dig,
		groups = {cracky = 1, level = 2, ud_param2_colorable = 1, not_in_creative_inventory = 1},
	})

	minetest.override_item("default:steelblock", {
		palette = "unifieddyes_palette_extended.png",
		airbrush_replacement_node = "steel:steel_block",
		groups = {cracky = 1, level = 2, ud_param2_colorable = 1},
	})

	unifieddyes.register_color_craft({
		output = "steel:steel_block",
		palette = "extended",
		neutral_node = "default:steelblock",
		type = "shapeless",
		recipe = {"NEUTRAL_NODE", "MAIN_DYE",}
	})
end
