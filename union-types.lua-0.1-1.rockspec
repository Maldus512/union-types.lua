package = "UnionTypes"
version = "0.1-1"
source = {
    url = "https://github.com/Maldus512/union-types.lua",
    tag = "v0.1",
}
description = {
    summary = "Ergonomic union types in Lua",
    detailed = [[ ]],
    license = "MIT"
}
dependencies = {
    "lua >= 5.1, < 5.4"
}
build = {
    type = "builtin",
    modules = {
        unionTypes = "src/union-types.lua",
    },
}
