---@class NPC
---@field private model string
NPC = {}
NPC.__index = NPC

---@param model string|number the model of the NPC or its hash
function NPC:Create(model)
    local npc = {}
    setmetatable(npc, NPC)
    npc.model = model
    return npc
end
