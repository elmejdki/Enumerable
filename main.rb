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
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity

%w[gogo toto boto].my_each { |x| puts x + "." }
