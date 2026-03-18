local Signal = require("engine.signal")

local Input = {}
Input.__index = Input

function Input.new()
  local self = setmetatable({}, Input)

  self.bindings = {}   -- key → action
  self.actions = {}    -- action → signals

  self.current = {}    -- action → bool
  self.previous = {}   -- action → bool

  return self
end

-- ========================
-- Bind
-- ========================

function Input:bind(key, action)
  self.bindings[key] = action

  if not self.actions[action] then
      self.actions[action] = {
          pressed = Signal.new(),
          released = Signal.new()
      }
      self.current[action] = false
      self.previous[action] = false
  end
end

-- ========================
-- LOVE Events
-- ========================

function Input:keypressed(key)
  local action = self.bindings[key]
  if not action then return end

  self.current[action] = true

  local a = self.actions[action]
  if a then
      a.pressed:emit(self, key)
  end
end

function Input:keyreleased(key)
  local action = self.bindings[key]
  if not action then return end

  self.current[action] = false

  local a = self.actions[action]
  if a then
      a.released:emit(self, key)
  end
end

-- ========================
-- Query API ( important)
-- ========================

function Input:is_action_pressed(action)
  return self.current[action] == true
end

function Input:is_action_just_pressed(action)
  return self.current[action] == true and self.previous[action] == false
end

function Input:is_action_just_released(action)
  return self.current[action] == false and self.previous[action] == true
end

-- ========================
-- Update (call every frame)
-- ========================

function Input:update()
  for action, state in pairs(self.current) do
      self.previous[action] = state
  end
end

return Input
