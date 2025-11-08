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

---@class vector3 : {x: number, y: number, z: number}
vector3 = {}

function vector3(x, y, z) end

---@nodiscard
---@param url string
---@param width number
---@param height number
---@return number duiObject
function CreateDui(url, width, height) end

---@param duiObject number
---@return number duiHandle
function GetDuiHandle(duiObject) end

---@param txdStr string
---@return number txd
function CreateRuntimeTxd(txdStr) end

---@param txd number
---@param txnStr string
---@param duiHandle number
---@return number txn
function CreateRuntimeTextureFromDuiHandle(txd, txnStr, duiHandle) end

---@param duiObject number
function DestroyDui(duiObject) end

---@nodiscard
---@param duiObject number
---@return boolean available
function IsDuiAvailable(duiObject) end

---@class json
json = {}

---@nodiscard
---@param obj table
---@return string jsonString
function json.encode(obj) end

---@param duiObject number
---@param message string
function SendDuiMessage(duiObject, message) end

---@param duiObject number
---@param button 'left' | 'right' | 'middle' | DUI.Button
function SendDuiMouseDown(duiObject, button) end

---@param duiObject number
---@param button 'left' | 'right' | 'middle' | DUI.Button
function SendDuiMouseUp(duiObject, button) end

---@param duiObject number
---@param x number
---@param y number
function SendDuiMouseWheel(duiObject, x, y) end

---@param duiObject number
---@param x number
---@param y number
function SendDuiMouseMove(duiObject, x, y) end

---@param duiObject number
---@param url string
function SetDuiUrl(duiObject, url) end

---@param modelHash number
function RequestModel(modelHash) end

---@param modelHash number
---@return boolean loaded
function HasModelLoaded(modelHash) end

---@param modelName string
function GetHashKey(modelName) end

---@param pedType number
---@param modelHash number
---@param x number
---@param y number
---@param z number
---@param heading number
---@param isNetworked boolean
---@param bScriptHostPed boolean
---@return number pedId
function CreatePed(pedType, modelHash, x, y, z, heading, isNetworked, bScriptHostPed) end

---@param modelHash number
function SetModelAsNoLongerNeeded(modelHash) end

---@param pedId number
function DeletePed(pedId) end
