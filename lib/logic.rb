module Logic
  Z = nil
  HIGH = true
  LOW = false

  INTEGER_LEVELS = {
    nil => Logic::Z,
    0 => Logic::LOW,
    1 => Logic::HIGH,
  }
end

require "logic/io"
require "logic/input"
require "logic/output"
require "logic/gate"
require "logic/gates"
require "logic/blocks"