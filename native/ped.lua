---@class Ped
---@field private id number?
---@field private modelHash number
---@field private networked boolean
Ped = {}
Ped.__index = Ped

---Awaits the loading of a model.
---@param modelHash number
local function awaitModel(modelHash)
    local now = GetGameTimer()
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) and GetGameTimer() - now < 1000 do
        Wait(0)
    end
    if not HasModelLoaded(modelHash) then
        error("Failed to load model: " .. tostring(modelHash))
    end
end

---Creates a new Ped instance.
---@nodiscard
---@param model string|number The model name or hash of the ped to create.
---@param networked boolean Whether the ped should be networked.
---@return Ped ped
function Ped.Create(model, networked)
    local modelHash = type(model) == "string" and GetHashKey(model) or model
    ---@cast modelHash number
    local ped = {}
    setmetatable(ped, Ped)
    ped.modelHash = modelHash
    ped.networked = networked
    return ped
end

---Spawns the ped at the given coordinates.
---@nodiscard
---@param coords vector4 The coordinates to spawn the ped at.
---@return number pedId
function Ped:Spawn(coords)
    if self.id then
        error("Ped has already been spawned.")
    end
    awaitModel(self.modelHash)
    self.id = CreatePed(
        4,
        self.modelHash,
        coords.x,
        coords.y,
        coords.z,
        coords.w or 0.0,
        self.networked,
        false
    )
    SetModelAsNoLongerNeeded(self.modelHash)
    return self.id
end

---Returns the ped ID.
---@nodiscard
---@return number pedId
function Ped:GetId()
    return self.id
end

---Deletes this ped.
function Ped:Delete()
    if not self.id then
        return
    end
    DeletePed(self.id)
    self.id = nil
end
