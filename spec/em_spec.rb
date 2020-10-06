require './enumerable_methods.rb'

describe Enumerable do
  let(:arr) { [6, 7, 8, 9] }
  let(:range) { (6..9) }
  let(:strings) { %w[cat sheep bear] }
  let(:edge_case) { [nil, true, 99] }

  describe '#my_each' do
    result = []
    it 'apply block on each element' do
      arr.my_each { |n| result.push(n + 3) }
      expect(result).to eql([9, 10, 11, 12])
    end
    it 'returns same array when given block' do
      expect(arr.my_each { |n| (n + 3) }).to eql(arr)
    end
    it 'returns enum if no block given' do
      expect(arr.my_each).to be_an Enumerator
    end
    it 'returns error if given argument' do
      expect{ arr.my_each(3) }.to raise_error(ArgumentError)
    end
  end

  describe '#my_each_with_index' do
    result = []
    it 'apply block on certain elements' do
      arr.my_each_with_index { |_n, i| result.push(arr[i] + 3) if i.even? }
      expect(result).to eql([9, 11])
    end
    it 'returns same array when given block' do
      expect(arr.my_each_with_index { |n| (n + 3) }).to eql(arr)
    end
    it 'returns enum if no block given' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end
    it 'returns error if given argument' do
      expect{ arr.my_each_with_index(3) }.to raise_error(ArgumentError)
    end
  end

  describe '#my_select' do
    it 'selects certain elements of block' do
      expect(arr.my_select { |n| n > 7 }).to eql([8, 9])
    end
    it 'returns enum if no block given' do
      expect(arr.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    it 'returns true if condition is true for all' do
      expect(arr.my_all? { |n| n > 4 }).to eql(true)
    end
    it 'returns false if condition is false for at least one' do
      expect(arr.my_all? { |n| n > 7 }).to eql(false)
    end
    it 'accepts arguments' do
      expect(arr.my_all?(Integer)).to eql(true)
    end
    it 'accepts strings' do
      expect(strings.my_all? { |word| word.length <= 6 }).to eql(true)
    end
    it 'checks if single elements are true if no block given' do
      expect(edge_case.my_all?).to eql(false)
    end
    it 'raises error if given undefined variable' do
      expect { und_var.my_all? }.to raise_error(NameError)
    end
  end

  describe '#my_any?' do
    it 'returns true if condition is true for at least one' do
      expect(arr.my_any? { |n| n > 7 }).to eql(true)
    end
    it 'returns false if condition is false for all' do
      expect(arr.my_any? { |n| n > 20 }).to eql(false)
    end
    it 'accepts arguments' do
      expect(arr.my_any?(7)).to eql(true)
    end
    it 'accepts strings' do
      expect(strings.my_any? { |word| word.length < 5 }).to eql(true)
    end
    it 'checks if single elements are true if no block given' do
      expect(edge_case.my_any?).to eql(true)
    end
    it 'raises error if given too many arguments' do
      expect { arr.my_all?(Integer, Float) }.to raise_error(ArgumentError)
    end
  end

  describe '#my_none?' do
    it 'returns true if condition is false for all' do
      expect(arr.my_none? { |n| n > 20 }).to eql(true)
    end
    it 'returns false if condition is true for at least one' do
      expect(arr.my_none? { |n| n > 8 }).to eql(false)
    end
    it 'accepts arguments' do
      expect(arr.my_none?(7)).to eql(false)
    end
    it 'accepts strings' do
      expect(strings.my_none? { |word| word.length < 5 }).to eql(false)
    end
    it 'checks if single elements are true if no block given' do
      expect(edge_case.my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'counts all elements' do
      expect(arr.my_count).to eql(4)
    end
    it 'counts certain elements' do
      expect(arr.my_count(&:even?)).to eql(2)
    end
    it 'accepts blocks' do
      expect(arr.my_count { |n| n == 7 }).to eql(1)
    end
  end

  describe '#my_map' do
    it 'runs block for each element' do
      expect(arr.my_map { |n| n * n }).to eql([36, 49, 64, 81])
    end
    it 'runs block for each element' do
      expect(range.my_map { |n| n * n }).to eql([36, 49, 64, 81])
    end
    it 'returns enum if no block given' do
      expect(arr.my_map).to be_an Enumerator
    end
  end

  describe '#my_inject' do
    it 'sums up every element' do
      expect(arr.my_inject(:+)).to eql(30)
    end
    it 'accepts ranges' do
      expect(range.my_inject(:+)).to eql(30)
    end
    it 'finds the longest word' do
      result = strings.my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(result).to eql('sheep')
    end
    it 'multplies all elements' do
      expect(range.my_inject(1, :*)).to eql(3024) 
    end
    it 'raises error if no block given and first argument equals 0' do
      expect{ range.my_inject(0, :*) }.to raise_error(LocalJumpError)
    end
  end

  describe '#multiply_els' do
    it 'multiplies all elements' do
      expect(multiply_els(arr)).to eql(3024)
    end
  end
end
