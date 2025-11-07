---@class Sprite
---@field private base64 string
---@field private txd number
---@field private txn number
Sprite = {}
Sprite.__index = Sprite

local function create_runtime_base64_sprite(base64)
    local txd = CreateRuntimeTxd('sprite_txd_' .. base64)
    local txn = CreateRuntimeTextureFromImage(txd, 'sprite_txn_' .. base64, base64)
    return txd, txn
end

---Creates a new Sprite instance from a base64 encoded image.
---@nodiscard
---@param base64 string the base64 encoded image data
---@return Sprite sprite
function Sprite:Create(base64)
    local sprite = {}
    setmetatable(sprite, Sprite)
    sprite.base64 = base64
    sprite.txd, sprite.txn = create_runtime_base64_sprite(base64)
    return sprite
end

print("TEST!!!!!!!!!!!!!!!!!!!!!!!!")
