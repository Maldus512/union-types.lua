local first_to_upper = function(str)
    return (str:gsub("^%l", string.upper))
end

local build_variant = function(name, parameters)
    local num_parameters = 0
    if parameters ~= nil then
        num_parameters = #parameters
    end

    return function(...)
        local args = { ... }
        if parameters ~= nil and #args ~= num_parameters then
            error("Enum variant " ..
                first_to_upper(name) .. " requires " .. tostring(num_parameters) .. " parameters")
        else
            return { [name] = args }
        end
    end
end


return {
    Type = function(variants)
        assert(type(variants) == "table", "Invalid argument for building a closed union type: " .. type(variants))

        local Variants = {}
        for key, value in pairs(variants) do
            if type(key) == "number" then
                Variants[value] = build_variant(value, nil)
            else
                Variants[key] = build_variant(key, value)
            end
        end

        return Variants
    end,
    match = function(instance)
        return function(branches)
            local instanceVariant = nil
            local instanceArgs = nil

            for variant, args in pairs(instance) do
                instanceVariant = variant
                instanceArgs = args
                break
            end

            if branches[instanceVariant] ~= nil then
                return branches[instanceVariant](table.unpack(instanceArgs))
            elseif branches._ ~= nil then
                return branches._(instance)
            else
                error("Non exhaustive pattern matching")
            end
        end
    end,
}
