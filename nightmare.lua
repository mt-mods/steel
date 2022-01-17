if minetest.settings:get_bool("creative_mode") and not minetest.get_modpath("unified_inventory") then
	steel_expect_infinite_stacks = true
else
	steel_expect_infinite_stacks = false
end

function steel_node_is_owned(pos, placer)
	local ownername = false
	if type(IsPlayerNodeOwner) == "function" then					-- node_ownership mod
		if HasOwner(pos, placer) then						-- returns true if the node is owned
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				if type(getLastOwner) == "function" then		-- ...is an old version
					ownername = getLastOwner(pos)
				elseif type(GetNodeOwnerName) == "function" then	-- ...is a recent version
					ownername = GetNodeOwnerName(pos)
				else
					ownername = "someone"
				end
			end
		end

	elseif type(isprotect)=="function" then						-- glomie's protection mod
		if not isprotect(5, pos, placer) then
			ownername = "someone"
		end
	elseif type(protector)=="table" and type(protector.can_dig)=="function" then					-- Zeg9's protection mod
		if not protector.can_dig(5, pos, placer) then
			ownername = "someone"
		end
	end

	if ownername ~= false then
		minetest.chat_send_player( placer:get_player_name(), ("Sorry, %s owns that spot."):format(ownername) )
		return true
	else
		return false
	end
end

function steel_rotate_and_place(itemstack, placer, pointed_thing)

	local node = minetest.get_node(pointed_thing.under)
	if not minetest.registered_nodes[node.name] or not minetest.registered_nodes[node.name].on_rightclick then
		if steel_node_is_owned(pointed_thing.above, placer) then
			return itemstack
		end
		local above = pointed_thing.above
		local under = pointed_thing.under
		local pitch = placer:get_look_pitch()
		local node = minetest.get_node(above)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local wield_name = itemstack:get_name()

		if node.name ~= "air" then return end

		local iswall = (above.x ~= under.x) or (above.z ~= under.z)
		local isceiling = (above.x == under.x) and (above.z == under.z) and (pitch > 0)

		if iswall then
			local dirs = { 2, 3, 0, 1 }
			minetest.add_node(above, {name = wield_name.."_wall", param2 = dirs[fdir+1] }) -- place wall variant
		elseif isceiling then
			minetest.add_node(above, {name = wield_name.."_wall", param2 = 19 }) -- place wall variant on ceiling
		else
			minetest.add_node(above, {name = wield_name }) -- place regular variant
		end

		if not steel_expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	else
		minetest.registered_nodes[node.name].on_rightclick(pointed_thing.under, node, placer, itemstack)
	end
end

minetest.register_node("steel:roofing", {
	description = "Corrugated steel roofing",
	drawtype = "raillike",
	tiles = {"corrugated_steel.png"},
	inventory_image = "corrugated_steel.png",
	wield_image = "corrugated_steel.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	on_place = function(itemstack, placer, pointed_thing)
		steel_rotate_and_place(itemstack, placer, pointed_thing)
		return itemstack
	end
})

minetest.register_node("steel:roofing_wall", {
	description = "Corrugated steel wall",
	drawtype = "nodebox",
	tiles = {"corrugated_steel.png"},
	inventory_image = "corrugated_steel.png",
	wield_image = "corrugated_steel.png",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	walkable = true,
	groups = {bendy=2,snappy=1,dig_immediate=2, not_in_creative_inventory=1},
	drop = "steel:roofing",
	on_place = function(itemstack, placer, pointed_thing)
		steel_rotate_and_place(itemstack, placer, pointed_thing)
		return itemstack
	end,
        node_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.48, 0.5, 0.5, -0.48 }
        },
        selection_box = {
                type = "fixed",
                fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, -0.4 }
        },
})

if homedecor_register_slope and homedecor_register_roof then
	homedecor_register_slope("steel", "roofing",
		"steel:roofing",
		{bendy=2,snappy=1,dig_immediate=2},
		{"corrugated_steel.png"},
		"Corrugated steel roofing"
	)
	homedecor_register_roof("steel", "roofing",
		{bendy=2,snappy=1,dig_immediate=2},
		{"corrugated_steel.png"},
		"Corrugated steel roofing"
	)
end
