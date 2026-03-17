local Signal = {}
Signal.__index = Signal

-- ========================
-- Constructor
-- ========================

function Signal.new()
    return setmetatable({
        listeners = {}
    }, Signal)
end

-- ========================
-- Connect
-- ========================

function Signal:connect(fn)
    self.listeners[#self.listeners + 1] = fn
    return fn
end

-- ========================
-- Emit (sender + data)
-- ========================

function Signal:emit(sender, ...)
    local listeners = self.listeners

    for i = 1, #listeners do
        listeners[i](sender, ...)
    end
end

-- ========================
-- Disconnect
-- ========================

function Signal:disconnect(fn)
    local listeners = self.listeners

    for i = 1, #listeners do
        if listeners[i] == fn then
            table.remove(listeners, i)
            return
        end
    end
end

-- ========================
-- Clear all listeners
-- ========================

function Signal:clear()
    self.listeners = {}
end

return Signal
