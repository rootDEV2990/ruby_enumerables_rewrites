require './myenumerables.rb'

describe Enumerable do 
    arr = [4, 20, 3, 22]

    describe '.my_each' do
        it 'Makes self into array unless block is given' do
            test1 = arr.my_each
            test2 = arr.each
            expect(test1 == test2)
        end
    end

    describe '.my_each_with_index' do
        it 'Take an array and gets the element and index of the block_given?' do
            test1 = arr.my_each_with_index
            test2 = arr.each_with_index
            expect(test1 == test2)
        end
    end

    describe '.my_select' do
        it 'Take an array and filters block_given' do
            test1 = arr.my_select { |item| item == 20}
            test2 = arr.select { |item| item == 20}
            expect(test1 == test2)
        end
    end

    describe '.my_any?' do
        it 'Take an array and filters to find if an element is included to return true or false' do
            test1 = arr.my_any?(100)
            test2 = arr.any?(100)
            expect(test1 == test2)
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