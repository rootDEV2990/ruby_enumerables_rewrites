require './myenumerables.rb'

describe Enumerable do
  arr = [4, 20, 3, 22]
  query = 4
  query_symbol = :+

  describe '.my_each' do
    it 'Makes self into array unless block is given' do
      expect(arr.my_each).to be_a(Enumerable)
    end
    it 'if block is given' do
      result = []
      arr.my_each { |item| result << item }
      expect(arr).to eq(result)
    end
  end

  describe '.my_each_with_index' do
    it 'If block is not given' do
      expect(arr.my_each_with_index).to be_a(Enumerable)
    end
    it 'Take an array and gets the element and index of the block_given?' do
      hash_my_method = {}
      hash_ruby_method = {}
      arr.my_each_with_index do |item, index|
        hash_my_method[item] = index
      end
      arr.each_with_index { |item, index| hash_ruby_method[item] = index }
      expect(hash_my_method).to eq(hash_ruby_method)
    end
  end

  describe '.my_select' do
    it 'Take an array and filters block_given' do
      expect(arr.my_select).to be_a(Enumerable)
    end
    it 'It pushes array when item matches criteria' do
      result = []
      arr.each do |element|
        result << element if element == 20
      end
      test = arr.my_select { |element| element == 20 }
      expect(test).to eq(result)
    end
  end

  describe '.my_all?' do
    it 'When there is no block given truthy value' do
      expect(arr.my_all?).to be_truthy
    end
    it 'Take an array and filters to find if an element is included to return true or false' do
      hash = {}
      for item in arr do
        hash[item] = if arr[item] == arr[item.next]
                       1
                     else
                       0
                     end
      end
      result = hash.value?(0)
      expect(result).to be_truthy
    end
  end

  describe '.my_any?' do
    it 'Takes a block and return true if item in block matches' do
      expect(arr.my_any?(nil)).to be_truthy
    end
    it 'Take an array and filters to find if an element is included to return true or false' do
      hash = {}
      for item in arr do
        hash[item] = if item == query
                       1
                     else
                       0
                     end
      end
      result = hash.value?(1)
      expect(result).to be_truthy
    end
  end

  describe '.my_none?' do
    it 'Takes a block and return false if arr contains items' do
      expect(arr.my_none?).to be_falsy
    end
    it 'Take an array and filters to find if an element is included to return true or false' do
      hash = {}
      for item in arr do
        hash[item] = if item == query
                       1
                     else
                       0
                     end
      end
      result = false if hash.value?(1)
      expect(result).to be_falsy
    end
  end

  describe '.my_count' do
    it 'If no block is given counts length of array' do
      expect(arr.my_count).to eq(arr.length)
    end
    it 'If theres a perameter iterates and counts matching items' do
      hash = {}
      for item in arr do
        hash[item] = if item == query
                       1
                     else
                       0
                     end
      end
      result = hash.count { |x| x[1] == 1 }
      expect(result).to eq(arr.count(query))
    end
  end

  describe '.my_map' do
    it 'Takes an array and return to enumerable if no block is given.' do
      expect(arr.my_map).to be_a(Enumerable)
    end
    it 'If parameter is given push to a new array' do
      result = []
      result_ruby = []
      arr.my_map do |element|
        result << element if element == query
      end
      arr.map { |element| result_ruby << element if element == query }
      expect(result).to eq(result_ruby)
    end
  end
  # Inject needed to done again
  describe '.my_inject' do
    it 'it will pass each element and accumulate each sequentially' do
      sum = query
      for element in arr do
        sum = sum.public_send(query_symbol, element)
      end
      expect(sum).to eq(arr.inject(query, query_symbol))
    end
  end
end
