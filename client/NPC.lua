---@class NPC
---@field private model string
NPC = {}
NPC.__index = NPC

---Creates a new NPC instance.
---@param model string|number the model of the NPC or its hash
function NPC:Create(model)
    local npc = {}
    setmetatable(npc, NPC)
    npc.model = model
    return npc
end

---Spawns the npc at the given location.
---@param coords vector4 the coordinates to spawn the npc at.
function NPC:Spawn(coords)

end
