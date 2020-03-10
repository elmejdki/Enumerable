# rubocop:disable Style/CaseEquality
module Enumerable
  def make_array(input)
    return input.to_a if input.class.name == 'Range'

    input
  end

  def my_each
    if block_given?
      for i in 0..length - 1 do
        yield(self[i])
      end

      self
    else
      to_enum
    end
  end

  def my_each_with_index
    if block_given?
      for i in 0..length - 1 do
        yield(self[i], i)
      end

      self
    else
      to_enum
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
      to_enum
    end
  end

  def my_all?(type = nil)
    if block_given?
      i = 0
      while i < length
        return false if yield(self[i]).nil? || yield(self[i]) == false

        i += 1
      end
    elsif type
      i = 0
      while i < length
        return false unless type === self[i]

        i += 1
      end
    else
      return my_all? { |x| x }
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
    elsif type
      i = 0
      while i < length
        return true if type === self[i]

        i += 1
      end
    else
      return my_any? { |x| x }
    end

    false
  end

  def my_none?(type = nil)
    if block_given?
      i = 0
      while i < length
        return false if yield(self[i])

        i += 1
      end
    elsif type
      i = 0
      while i < length
        return false if type === self[i]

        i += 1
      end
    else
      return my_none? { |x| x }
    end

    true
  end

  def my_count(item = false)
    count = 0
    if block_given?
      i = 0
      while i < length
        count += 1 if yield(self[i])
        i += 1
      end
    elsif item
      i = 0
      while i < length
        count += 1 if self[i] == item
        i += 1
      end
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

  def my_inject(first = false, second = false)
    arr = make_array(self)

    memo = 0
    if !block_given?
      if first && second
        memo = first
        arr.my_each { |item| memo = memo.method(second).call(item) }
        memo
      elsif first
        memo = arr[0]
        arr.my_each_with_index do |item, index|
          next if index.zero?

          memo = memo.method(first).call(item)
        end

        memo
      end
    elsif first
      memo = first
      arr.my_each { |item| memo = yield(memo, item) }
      memo
    else
      memo = arr[0]
      arr.my_each_with_index do |item, index|
        next if index.zero?

        memo = yield(memo, item)
      end

      memo
    end
  end
end
# rubocop:enable Style/CaseEquality

def multiply(input)
  input.my_inject(:*)
end
