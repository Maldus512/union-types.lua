local unionTypes = require "src.union-types"
local match = unionTypes.match
local Type = unionTypes.Type

---@class Option.None
---@class Option.Some
---@alias Option Option.Some | Option.None

---@class OptionGeneric
---@field Some fun(any) : Option.Some
---@field None fun() : Option.None

do
    ---@type OptionGeneric
    local Option = Type {
        Some = { "value" },
        None = {},
    }
    local some = Option.Some("Hello")
    local none = Option.None()

    match(some) {
        None = function() error "Wrong variant!" end,
        Some = function(value) assert(value == "Hello") end
    }

    match(none) {
        Some = function(_) error "Wrong variant!" end,
        _ = function(_)
        end,
    }
end

do
    local Option = Type {
        "Some", "None"
    }
    local some = Option.Some("Hello", 4)
    local none = Option.None("ignored")

    match(some) {
        None = function(_, _, _) error "Wrong variant!" end,
        Some = function(value, num)
            assert(value == "Hello")
            assert(num == 4)
        end
    }

    match(none) {
        Some = function(_) error "Wrong variant!" end,
        _ = function(_)
        end,
    }
end

print("union module tests successful!")
