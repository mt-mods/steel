unused_args = false
allow_defined_top = true

exclude_files = {".luacheckrc"}

globals = {
    "minetest", "core",
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Luac
    "math", "table",

    -- Builtin
    "vector", "ItemStack", "dump", "DIR_DELIM", "VoxelArea", "Settings", "PcgRandom", "VoxelManip", "PseudoRandom",

    -- Mod produced
    "default", "unifieddyes", "homedecor_roofing",
}