# rubocop:disable Style/CaseEquality
# rubocop:disable Metrics/ModuleLength
module Enumerable
  def make_array
    return self.to_a if self.class.name == 'Range'

    self
  end

  def my_each
    arr = self.make_array

    if block_given?
      i = 0
      while i < arr.length
        yield(arr[i])
        i += 1
      end

      arr
    else
      to_enum
    end
  end

  def my_each_with_index
    arr = self.make_array

    if block_given?
      i = 0
      while i < arr.length
        yield(arr[i], i)
        i += 1
      end

      arr
    else
      to_enum
    end
  end

  def my_select
    arr = []

    if block_given?
      my_each { |item| arr.push(item) if yield(item) }

      arr
    else
      to_enum
    end
  end

  def my_all?(type = nil)
    if block_given?
      my_each { |item| return false if yield(item).nil? || yield(item) == false }
    elsif type
      my_each { |item| return false unless type === item }
    else
      return my_all? { |x| x }
    end

    true
  end

  def my_any?(type = nil)
    if block_given?
      my_each { |item| return true if !yield(item).nil? && yield(item) != false }
    elsif type
      my_each { |item| return true if type === item }
    else
      return my_any? { |x| x }
    end

    false
  end

  def my_none?(type = nil)
    if block_given?
      my_each { |item| return false if yield(item) }
    elsif type
      my_each { |item| return false if type === item }
    else
      return my_none? { |x| x }
    end

    true
  end

  def my_count(item = false)
    count = 0
    if block_given?
      my_each { |ele| count += 1 if yield(ele) }
    elsif item
      my_each { |ele| count += 1 if ele == item }
    else
      count = length
    end

    count
  end

  def my_map(proc = false)
    if proc
      arr = []
      i = 0
      while i < length
        arr.push(proc.call(self[i]))
        i += 1
      end

      arr
    elsif block_given?
      arr = []
      i = 0
      while i < length
        arr.push(yield(self[i]))
        i += 1
      end

      arr
    else
      to_enum
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def my_inject(first = false, second = false)
    arr = self.make_array

    memo = 0
    if !block_given?
      if first && second
        memo = first
        arr.my_each { |item| memo = memo.method(second).call(item) }
      elsif first
        memo = arr[0]
        arr.my_each_with_index do |item, index|
          next if index.zero?

          memo = memo.method(first).call(item)
        end
      end
    elsif first
      memo = first
      arr.my_each { |item| memo = yield(memo, item) }
    else
      memo = arr[0]
      arr.my_each_with_index do |item, index|
        next if index.zero?

        memo = yield(memo, item)
      end
    end

    memo
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
end
# rubocop:enable Style/CaseEquality
# rubocop:enable Metrics/ModuleLength

def multiply(input)
  input.my_inject(:*)
end
