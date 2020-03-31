require './main'

RSpec.describe Enumerable do
  describe '#make_array' do
    it 'returns an array from a range' do
      range = (1..3)
      expect(range.make_array.class).to eql( Array )
    end
  end

  describe '#my_each' do
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

  describe '#my_each_with_index' do
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

  describe '#my_select' do
    let(:arr) { [1,2,3,4,5] }

    it 'Returns the elements of the array wich evaluates to a given block to true' do      
      expect(arr.my_select{ |x| x.even? }).to eql([2,4])
    end

    it 'returns Enum if there is no block' do      
      expect(arr.my_select.class).to eql(Enumerator)
    end
  end

  # describe '#my_all?' do
    
  # end
end
