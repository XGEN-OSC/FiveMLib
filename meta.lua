---@meta FIVEM

---@class vector4 : {x: number, y: number, z: number, w: number}
vector4 = {}

---@type number
source = 0

---@nodiscard
---@param x number
---@param y number
---@param z number
---@param w number
---@return vector4
function vector4(x, y, z, w) end

---@param eventName string
---@param callback fun(...)
function RegisterNetEvent(eventName, callback) end

---@param eventName string
---@vararg any
function TriggerServerEvent(eventName, ...) end

---@param eventName string
---@param target number
---@vararg any
function TriggerClientEvent(eventName, target, ...) end

---@nodiscard
---@return number ms
function GetGameTimer() end

---@param ms number
function Wait(ms) end

---@nodiscard
---@return boolean isServer
function IsDuplicityVersion() end

---@param url string
---@param callback fun(statusCode: number, response: string, headers: table<string, string>)
function PerformHttpRequest(url, callback) end
