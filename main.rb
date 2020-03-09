# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each
    for i in 0..length - 1 do
      yield(self[i])
    end

    self
  end

  def my_each_with_index
    for i in 0..length - 1 do
      yield(self[i], i)
    end

    self
  end

  def my_select
    arr = []
    for i in 0..length - 1 do
      arr.push(self[i]) if yield(self[i])
    end

    arr
  end

  def my_all?(type = nil)
    if self.block_given?
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

  def my_any?
    if self.block_given?
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
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

# %w[gogo toto boto].my_each { |x| puts x + "." }

# puts %w[ant bear cat].all? { |word| word.length >= 3 }
# puts [true, false, nil].all?
# puts (1..10).all?{ |word| word >= 3 }
# puts [].all?
# puts %w[ant bear cat].any? { |word| word.length >= 4 }
puts [].any?
