local fetch_module = function(module)
    error("not implemented")
end

---@type table<string, string> the fetched modules
local module_cache = {}

---@type table<string, boolean>
local loaded_modules = {}

if IsDuplicityVersion() then
    local script_host = "https://raw.githubusercontent.com/XGEN-OSC/FiveMLib/refs/heads/main/"

    fetch_module = function(module)
        if module_cache[module] then return end
        local done = false
        local content = nil
        PerformHttpRequest(script_host .. module .. ".lua", function(err, response)
            if err ~= 200 then
                print("Error fetching module:", err)
                return
            end

            module_cache[module] = content
            content = response
            done = true
        end)

        local now = GetGameTimer()
        while not done and GetGameTimer() - now < 5000 do
            Wait(0)
        end
        if not done then
            error("Timeout fetching module: " .. module)
        end
    end

    RegisterNetEvent('xgen:fivelib:fetch:module', function(module)
        local player = source
        fetch_module(module)
        TriggerClientEvent(player, 'xgen:fivelib:set:module', module, module_cache[module])
    end)
else
    ---@type table<string, table<fun()>>
    local module_fetchers = {}

    fetch_module = function(module)
        if module_cache[module] then return end
        local list = module_fetchers[module] or {}
        local done = false
        table.insert(list, function()
            done = true
        end)
        module_fetchers[module] = list
        TriggerServerEvent('xgen:fivelib:fetch:module', module)
        local now = GetGameTimer()
        while not done and GetGameTimer() - now < 5000 do
            Wait(0)
        end
        if not done then
            error("Timeout fetching module: " .. module)
        end
    end

    RegisterNetEvent('xgen:fivelib:set:module', function(module, content)
        module_cache[module] = content
        local list = module_fetchers[module] or {}
        for _, cb in ipairs(list) do
            cb()
        end
        module_fetchers[module] = nil
    end)
end

local function load_module(module)
    if loaded_modules[module] then return end
    if module_cache[module] == nil then error("tried to load unknown module '" .. tostring(module) .. "'") end
    loaded_modules[module] = true
    assert(load(module_cache[module]))
end

---Loads the given module.
---e.g. require("client/NPC") will request the script "https://raw.githubusercontent.com/XGEN-OSC/FiveMLib/refs/heads/main/client/NPC.lua"
---@param module string the module (relative to the script_host)
function require(module)
    fetch_module(module)
    load_module(module)
end
