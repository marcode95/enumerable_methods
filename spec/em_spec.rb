require './enumerable_methods.rb'
describe Enumerable do
  let(:arr) { [6, 7, 8, 9] }
  let(:range) { (6..9) }
  let(:strings) { %w[cat sheep bear] }
  describe '#my_each' do
    result = []
    it 'apply block on each element' do
      arr.my_each { |n| result.push(n + 3) }
      expect(result).to eql([9, 10, 11, 12])
    end
    it 'returns same array when given block' do
      result = arr.my_each { |n| (n + 3) }
      expect(result).to eql(arr)
    end
  end
  describe '#my_each_with_index' do
    result = []
    it 'apply block on certain elements' do
      arr.my_each_with_index { |_n, i| result.push(arr[i] + 3) if i.even? }
      expect(result).to eql([9, 11])
    end
    it 'returns same array when given block' do
      result = arr.my_each_with_index { |n| (n + 3) }
      expect(result).to eql(arr)
    end
  end
  describe '#my_select' do
    it 'selects certain elements of block' do
      result = arr.my_select { |n| n > 7 }
      expect(result).to eql([8, 9])
    end
  end
  describe '#my_all?' do
    it 'returns true if condition is true for all' do
      result = arr.my_all? { |n| n > 4 }
      expect(result).to eql(true)
    end
    it 'returns false if condition is false for at least one' do
      result = arr.my_all? { |n| n > 7 }
      expect(result).to eql(false)
    end
    it 'accepts parameters' do
      result = arr.my_all?(7)
      expect(result).to eql(false)
    end
  end
  describe '#my_any?' do
    it 'returns true if condition is true for at least one' do
      result = arr.my_any? { |n| n > 7 }
      expect(result).to eql(true)
    end
    it 'returns false if condition is false for all' do
      result = arr.my_any? { |n| n > 20 }
      expect(result).to eql(false)
    end
    it 'accepts parameters' do
      result = arr.my_any?(7)
      expect(result).to eql(true)
    end
  end
  describe '#my_none?' do
    it 'returns true if condition is false for all' do
      result = arr.my_none? { |n| n > 20 }
      expect(result).to eql(true)
    end
    it 'returns false if condition is true for at least one' do
      result = arr.my_none? { |n| n > 8 }
      expect(result).to eql(false)
    end
    it 'accepts parameters' do
      result = arr.my_none?(7)
      expect(result).to eql(false)
    end
  end
  describe '#my_count' do
    it 'counts all elements' do
      result = arr.my_count
      expect(result).to eql(4)
    end
    it 'counts certain elements' do
      result = arr.my_count(&:even?)
      expect(result).to eql(2)
    end
    it 'accepts blocks' do
      result = arr.my_count { |n| n == 7 }
      expect(result).to eql(1)
    end
  end
  describe '#my_map' do
    it 'runs block for each element' do
      result = arr.my_map { |n| n * n }
      expect(result).to eql([36, 49, 64, 81])
    end
  end
  describe '#my_inject' do
    it 'sums up every element' do
      result = arr.my_inject(:+)
      expect(result).to eql(30)
    end
    it 'accepts ranges' do
      result = range.my_inject(:+)
      expect(result).to eql(30)
    end
    it 'finds the longest word' do
      result = strings.my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(result).to eql('sheep')
    end
  end
end
