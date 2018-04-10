-- Craft items.
minetest.register_craftitem("tiplanium:tiplanium_lump", {
	description = "Tiplanium Lump",
	inventory_image = "tiplanium_lump.png",
})

minetest.register_craftitem("tiplanium:tiplanium_ingot", {
	description = "Tiplanium Ingot",
	inventory_image = "tiplanium_ingot.png",
})

-- Crafting.
minetest.register_craft({
	output = 'tiplanium:sword_tiplanium',
	recipe = {
		{'tiplanium:tiplanium_ingot'},
		{'tiplanium:tiplanium_ingot'},
		{'group:stick'},
	}
})

-- Cooking

minetest.register_craft({
	type = "cooking",
	output = "tiplanium:tiplanium_ingot",
	recipe = "tiplanium:tiplanium_lump",
})

-- Tools.

minetest.register_tool("tiplanium:sword_tiplanium", {
	description = "Tiplanium Sword",
	inventory_image = "tiplanium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.8, [2]=1.8, [3]=0.6}, uses=80, maxlevel=3},
		},
		damage_groups = {fleshy=16},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Ore tiplanium.
minetest.register_node("tiplanium:stone_with_tiplanium", {
	description = "Tiplanium Ore",
	tiles = {"default_stone.png^mineral_tiplanium.png"},
	groups = {cracky = 3},
	drop = 'tiplanium:tiplanium_lump',
	sounds = default.node_sound_stone_defaults(),
})

-- Tiplanium ore spawn.
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "tiplanium:stone_with_tiplanium",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20 * 20,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min          = 1025,
	y_max          = 31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "tiplanium:stone_with_tiplanium",
	wherein        = "default:stone",
	clust_scarcity = 22 * 22 * 22,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min          = -255,
	y_max          = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "tiplanium:stone_with_tiplanium",
	wherein        = "default:stone",
	clust_scarcity = 20 * 20 * 20,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -256,
})