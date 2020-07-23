require './myenumerables.rb'

describe Enumerable do 
    arr = [4, 20, 3, 22]

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
            hash_my_method = Hash.new
            hash_ruby_method = Hash.new
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
        it'It pushes array when item matches criteria' do
            result = []
            arr.each do |element| 
                result << element if element == 20
            end
            test = arr.my_select {|element| element == 20}
            expect(test).to eq(result)
        end
    end

    describe '.my_any?' do 
        it 'When there is no block given truthy value' do
            expect(arr.my_all?).to be_truthy
        end
        it 'Take an array and filters to find if an element is included to return true or false' do
            hash = {}
            for item in arr do 
                if arr[item] == arr[item.next]
                    hash[item] = 1 
                else
                    hash[item] = 0
                end
            end
            result = hash.has_value?(0)
            expect(result).to be_truthy 
        end
    end

    describe '.my_count' do
        it 'Take an array and counts how many elements meet the criteria' do
            test1 = arr.my_count
            test2 = arr.count
            expect(test1 == test2)
        end
    end

    describe '.my_map' do
        it 'Takes an array and transforms it.' do
            test1 = arr.my_map
            test2 = arr.map
            expect(test1 == test2)
        end
    end

    describe '.my_inject' do
        it 'it will pass each element and accumulate each sequentially' do
            test1 = arr.my_inject(0) { |total, n| total + n }
            test2 = arr.inject(0) { |total, n| total + n }
            expect(test1 == test2)
        end
    end
end