# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each
    if block_given?
      for i in 0..length - 1 do
        yield(self[i])
      end

      self
    else
      self.to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..length - 1 do
        yield(self[i], i)
      end

      self
    else
      self.to_enum
    end
  end

  def my_select
    arr = []

    if block_given?
      for i in 0..length - 1 do
        arr.push(self[i]) if yield(self[i])
      end
    
      arr
    else
      self.to_enum
    end
  end

  def my_all?(type = nil)
    if block_given?
      i = 0
      while i < length
        return false if yield(self[i]).nil? || yield(self[i]) == false

        i += 1
      end
    else
      if type
        i = 0
        while i < length
          return false if !(type === self[i])

          i += 1
        end
      else
        my_all? { |x| x }
      end
    end

    true
  end

  def my_any?(type = nil)
    if block_given?
      i = 0
      while i < length
        return true if !yield(self[i]).nil? && yield(self[i]) != false

        i += 1
      end
    else
      if type
        i = 0
        while i < length
          return true if type === self[i]

          i += 1
        end
      else
        my_any? { |x| x }
      end
    end

    false
  end

  def my_none?(type = nil)
    if block_given?
      i = 0
      while i < length
        return false if yield(self[i]) == true

        i += 1
      end
    else
      if type
        i = 0
        while i < length
          return false if type === self[i]

          i += 1
        end
      else
        my_any? { |x| x }
      end
    end

    true
  end

  def my_count(item = false)
    count = 0
    if block_given?
      i = 0
      while i < length
        count += 1 if yield(self[i])
      end
    else
      if item
        i = 0
        while i < length
          count += 1 if self[i] == item
        end
      else
        count = length
      end
    end

    count
  end

  def my_map(proc)
    arr = []
    i = 0
    while i < length
      arr.push(proc.call(self[i]))
      i += 1
    end

    arr
  end

  def my_inject(first = false, second = false)
    memo = 0
    if !block_given?
      if first && second
        memo = first
        self.my_each { |item| memo = memo.method(second).call(item) }
        memo
      elsif first
        memo = self[0]
        self.my_each_with_index do |item, index|
          if index == 0
            next
          else
            memo = memo.method(first).call(item)
          end
        end

        memo
      end
    else
      if first
        memo = first
        self.my_each{ |item| memo = yield(memo, item) }
        memo
      else
        memo = self[0]
        self.my_each_with_index do |item, index|
          if index == 0
            next
          else
            memo = yield(memo, item)
          end
        end

        memo
      end
    end
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

def multiply(input)
  input.my_inject(:*)
end

# puts multiply([2,4,5])

# %w[gogo toto boto].my_each { |x| puts x + "." }

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 }
# puts [true, false, nil].my_all?
# puts (1..10).my_all?{ |word| word >= 3 }
# puts [].my_all?

# puts %w[ant bear cat].my_any? { |word| word.length >= 4 }
# puts [].my_any?

# puts [1, 3.32, 42].my_none?(Float)

# arr = [1,2,4,2]
# puts arr.count
# puts arr.count(2)
# puts arr.count{ |x| x % 2 == 0 }

proc = Proc.new { |i| i*i }

print [1,2,3,4].my_map(proc)
puts ""

# test = [5,6,7,8,9,10].my_inject(1) do |product, n| 
#   product * n
# end

# puts test

# longest = %w{ cat sheep bear }.inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest 

# puts [5,6,7,8,9,10].inject { |sum, n| sum + n } 
