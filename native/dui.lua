---@class DUI
---@field private url string
---@field private width number
---@field private height number
---@field private obj number
---@field private handle number
---@field private texture {txd: number, txnStr: string, txn: number?}
DUI = {}
DUI.__index = DUI

---@enum DUI.Button
DUI.Button = {
    LEFT = "left",
    MIDDLE = "middle",
    RIGHT = "right",
}

---Creates a new texture dictionary and texture name
---@return {txd: number, txnStr: string}
local function texture()
    local txdName = "dui_txd_" .. tostring(math.random(1000000, 9999999))
    local txnName = "dui_txn_" .. tostring(math.random(1000000, 9999999))

    local txd = CreateRuntimeTxd(txdName)
    return { txd = txd, txnStr = txnName }
end

---Creates a new DUI object.
---@nodiscard
---@param url string The URL to load in the DUI.
---@param width number The width of the DUI.
---@param height number The height of the DUI.
---@return DUI dui
function DUI.Create(url, width, height)
    local dui = {}
    setmetatable(dui, DUI)
    dui.url = url
    dui.width = width
    dui.height = height
    dui.obj = CreateDui(url, width, height)
    dui.handle = GetDuiHandle(dui.obj)
    dui.texture = texture()
    return dui
end

---Checks if the DUI browser for this object is loaded.
---@nodiscard
---@return boolean available
function DUI:IsAvailable()
    return IsDuiAvailable(self.obj)
end

---Returns the current texture information.
---This will create/update the texture from the DUI object first.
---@return {txd: number, txn: number} texture
function DUI:GetTexture()
    self.texture.txn = CreateRuntimeTextureFromDuiHandle(self.texture.txd, self.texture.txnStr, self.obj)
    return { txd = self.texture.txd, txn = self.texture.txn }
end

---Sends a message to the DUI browser.
---@param obj table The object to send as a message.
function DUI:SendMessage(obj)
    SendDuiMessage(self.obj, json.encode(obj))
end

---Sends a mouse button event to the DUI browser.
---@param button DUI.Button The mouse button to send.
function DUI:MouseDown(button)
    SendDuiMouseDown(self.obj, button)
end

---Sends a mouse move event to the DUI browser.
---@param x number The x coordinate to move to.
---@param y number The y coordinate to move to.
function DUI:MouseMove(x, y)
    SendDuiMouseMove(self.obj, x, y)
end

---Sends a mouse button event to the DUI browser.
---@param button DUI.Button The mouse button to send.
function DUI:MouseUp(button)
    SendDuiMouseUp(self.obj, button)
end

---Sends a mouse wheel event to the DUI browser.
---@param scroll number The amount to scroll.
function DUI:MouseWheel(scroll)
    SendDuiMouseWheel(self.obj, scroll, 0)
end

---Sets the URL of the DUI browser.
---@param url string The URL to set.
function DUI:SetUrl(url)
    self.url = url
    SetDuiUrl(self.obj, url)
end

---Destroys the dui object.
---After this DUI:UpdateTexture will no longer work.
function DUI:Destroy()
    DestroyDui(self.obj)
end
