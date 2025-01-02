function change(amount)
  if math.type(amount) ~= "integer" then
    error("Amount must be an integer")
  end
  if amount < 0 then
    error("Amount cannot be negative")
  end
  local counts, remaining = {}, amount
  for _, denomination in ipairs({25, 10, 5, 1}) do
    counts[denomination] = remaining // denomination
    remaining = remaining % denomination
  end
  return counts
end

-- Write your first then lower case function here
  function first_then_lower_case(a, p)
    for _, i in ipairs(a) do
      if p(i) then
        return string.lower(i)        
      end
    end
    return nil
  end

-- Write your powers generator here
function powers_generator(base, limit)
  local total = 1
  -- create coroutine
  return coroutine.create(function()
    while total <= limit do
      -- pause coroutine and return total
      coroutine.yield(total)
      total = total * base
    end
  -- need to close coroutine with parenthesis
  end)
end

-- Write your say function here
  function say(sentence)
    local words = {}
    -- concatenation helper function 
    local function combine(word)
      -- instead of for loop, return the function to itself so that itll run again  
      if word then
            table.insert(words, word)
            return combine 
        else
            return table.concat(words, " ")
        end
    end

    -- start the chain of words
    if sentence then
        table.insert(words, sentence)
        return combine
    else
        return ""
    end
end

-- Write your line count function here
-- open file, if file can't be open throw an error, if it can be openned iterate over each line in the file, get rid of whitespace, if not empty add it
  function meaningful_line_count(file)
      -- Attempt to open the file for reading
      local f, err = io.open(file, "r")
      local counter = 0
      if not f then
          error("Can't open file: " .. err)
      end
      for line in f:lines() do
        --whitespace strip
          line = line:match("^%s*(.-)%s*$")
          if line ~= "" and not line:find("^#") then
              counter = counter + 1
          end
      end
      f:close()
      return counter
  end

-- Write your Quaternion table here

local input = io.read() 
Quaternion = {}
for number in string.gmatch(input, "[^%s]+") do
    table.insert(Quaternion, number)
end

-- function tostring()
--   local output = ""
--   local var = {"", "i", "j", "k"}
--   local counter = 1
--   for key,value in next, Quaternion, nil do 
--     print(key)
--     output = (output.." "..value.." "..var[counter].." ")
--     counter = counter + 1
--   end
--   return output
-- end

function add()
  
end

-- 000000000000000000000000

Quaternion = {}

Quaternion = (function (class)
  class.new = function (a, b, c, d)
    return setmetatable({a = a, b = b, c = c, d = d}, {
      __index = {

        conjugate = function(self)
          return class.new(self.a, self.b * (-1), self.c * (-1), self.d * (-1))
        end,

        coefficients = function(self)
          return {self.a, self.b, self.c, self.d}
        end

      },
      __add = function(self, other)
        return class.new(self.a + other.a, self.b + other.b, self.c + other.c, self.d + other.d)
      end,

      __mul = function(self, other)
        aProduct = (self.a * other.a) - (self.b * other.b) - (self.c * other.c) - (self.d * other.d)
        bProduct = (self.a * other.b) + (self.b * other.a) + (self.c * other.d) - (self.d * other.c)
        cProduct = (self.a * other.c) - (self.b * other.d) + (self.c * other.a) + (self.d * other.b)
        dProduct = (self.a * other.d) + (self.b * other.c) - (self.c * other.b) + (self.d * other.a)
        return class.new(aProduct, bProduct, cProduct, dProduct)
      end,

      __eq = function(self, other)
        return self.a == other.a and self.b == other.b and self.c == other.c and self.d == other.d
      end,

      __tostring = function(self)
        local function formatComponent(coefficient, vector)
          coefficient = coefficient + .0
          local str = tostring(coefficient)
          if str == '0.0' then
            return ''
          elseif str == '1.0' then
            return vector
          elseif str == '-1.0' then
            return '-' .. vector
          else
            return str ..vector
          end
        end

        self.a = self.a + .0

        if tostring(self.a) == '0.0' then
          nString = ''
        else
          nString = tostring(self.a)
        end

        local iString = formatComponent(self.b, 'i')
        local jString = formatComponent(self.c, 'j')
        local kString = formatComponent(self.d, 'k')

        returnString = nString .. '+' .. iString .. '+' .. jString .. '+' .. kString

        returnString = returnString:gsub('%++', '+')
        returnString = returnString:gsub('%+%-', '-')

        if returnString == '' then
          return '0'
        end

        if string.sub(returnString, -1) == '+' then
          returnString = string.sub(returnString, 1, -2)
        end

        if string.sub(returnString, 1, 1) == '+' then
          returnString = string.sub(returnString, 2)
        end     

        if returnString == '' then
          return '0'
        end
  
        return returnString
      end
    })
    end
  return class
end)({})