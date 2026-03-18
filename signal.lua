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
-- Supports:
--   connect(fn)
--   connect(obj, fn)
-- ========================

function Signal:connect(a, b)
  local listener = {}

  -- Case 1: connect(fn)
  if b == nil then
      listener.original = a
      listener.callback = a

  -- Case 2: connect(obj, fn)
  else
      listener.original = b
      listener.object = a

      listener.callback = function(...)
          return b(a, ...)
      end
  end

  table.insert(self.listeners, listener)

  -- Capture signal reference BEFORE defining function
  local selfSignal = self

  -- ========================
  -- Connection Object
  -- ========================
  local connection = {}

  function connection:disconnect()
      local listeners = selfSignal.listeners

      for i = 1, #listeners do
          if listeners[i] == listener then
              table.remove(listeners, i)
              return
          end
      end
  end

  return connection
end

-- ========================
-- Emit (safe iteration)
-- ========================

function Signal:emit(sender, ...)
  local listeners = self.listeners

  -- Create snapshot to avoid modification issues
  local snapshot = {}
  for i = 1, #listeners do
      snapshot[i] = listeners[i]
  end

  for i = 1, #snapshot do
      snapshot[i].callback(sender, ...)
  end
end

-- ========================
-- Disconnect by function
-- ========================

function Signal:disconnect(fn)
  local listeners = self.listeners

  for i = 1, #listeners do
      if listeners[i].original == fn then
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
