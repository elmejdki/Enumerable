require './main'

RSpec.describe Enumerable do
  let(:arr) { [1,2,3] }
  context '#make_array' do
    it 'returns an array from a range' do
      range = (1..3)
      expect(range.make_array.class).to eql( Array )
    end
  end

  context '#my_each' do
    let(:arr) { [1,2,3,4,5] }

    it 'returns the same array that it was given' do
      expect(arr.my_each{ |v| v + 3 }).to eql(arr)
    end

    it 'make sure the block is called for each element' do
      sum = 0

      arr.my_each do |number|
        sum += number
      end

      expect(sum).to eql(15)
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_each.class).to eql(Enumerator)
    end
  end

  context '#my_each_with_index' do
    let(:arr) { [1,2,3,4,5] }

    it "Calls each element and the index and pass them to the block" do
      result = []
      arr.my_each_with_index{ |v, i| result << (v * i) }
      expect(result).to eql([0, 2, 6, 12, 20])
    end

    it 'returns an enumerator if no block is given' do
      expect(arr.my_each_with_index.class).to eql(Enumerator)
    end
  end

  context '#my_select' do
    let(:arr) { [1,2,3,4,5] }

    it 'Returns the elements of the array wich evaluates to a given block to true' do      
      expect(arr.my_select{ |x| x.even? }).to eql([2,4])
    end

    it 'returns Enum if there is no block' do      
      expect(arr.my_select.class).to eql(Enumerator)
    end

    it 'returns a valid array from a range' do
      expect((1..6).my_select { |v| v.even? }).to eql([2, 4, 6])
    end
  end

  context '#my_all?' do
    it 'returns false when one of the values is false' do
      expect([1, 2, 3, false, 7, 8].my_all?).to eql(false)
    end

    it 'return true if all the values evaluated to true' do
      expect([1, 2, 3, 5, 7, 8].my_all?).to eql(true)
    end

    it 'returns false when one of the values is bigger than or equal to 4' do
      expect((1..4).my_all? { |v| v >= 4 }).to eql(false)
    end

    it 'returns true if all the values are even' do
      expect([2, 4, 6].my_all?{ |v| v.even?  }).to eql(true)
    end
  end

  context '#my_any?' do
    it 'returns false when all of the values are false' do
      expect([false, false, false].my_any?).to eql(false)
    end

    it 'return true if one value evaluate to true' do
      expect([false, false, 3].my_any?).to eql(true)
    end

    it 'return true if one number is even' do
      expect((1..4).my_any? { |v| v.even? }).to eql(true)
    end

    it 'return false if all the values are not bigger than 0' do
      expect([-2, -4, -6].my_any?{ |v| v >= 0  }).to eql(false)
    end
  end

  context '#my_none?' do
    it 'returns true when all of the values are false' do
      expect([false, false, false].my_none?).to eql(true)
    end

    it 'return false if one value evaluate to true' do
      expect([false, false, 3].my_none?).to eql(false)
    end

    it 'return false if one number is even' do
      expect((1..4).my_none? { |v| v.even? }).to eql(false)
    end

    it 'return true if all the values are not bigger than 0' do
      expect([-2, -4, -6].my_none?{ |v| v >= 0  }).to eql(true)
    end
  end

  context '#my_count' do
    it 'Returns the count of each element that yield true after evaluation' do     
      expect(arr.my_count{ |x| x > 2 }).to eql(1)
    end

    it 'Returns the count of items that are equal to the element given' do      
      expect(arr.my_count(2)).to eql(1)
    end

    it 'Count the number of elements in the array' do
      expect(arr.my_count).to eql(3)
    end
  end

  context '#my_map' do    
    it 'Returns a new array with the sum of two for each element' do
      expect(arr.my_map{ |x| x + 2 }).to eql([3, 4, 5])
    end

    it 'return a new array multiplying the original by 2' do
      proc = Proc.new { |v| v * 2 }
      expect(arr.my_map(proc)).to eql([2, 4, 6])
    end

    it 'return an enumerator if no block or proc is given' do
      expect(arr.my_map.class).to eql(Enumerator)
    end
  end

  context '#my_inject' do
    let(:range) { (5..10) } 
    it 'return the sum of values inside the range' do
      expect(range.my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'return the multiplication of values inside the range with an initial value of 1' do
      expect(range.my_inject(1) { |product, n| product * n }).to eql(151200)
    end

    it 'return the sum of the array with a symbol' do
      expect(range.my_inject(:+)).to eql(45)
    end

    it 'return the sum of the array with a symbol and an initial value of 3' do
      expect(range.my_inject(3, :+)).to eql(48)
    end
  end
end
