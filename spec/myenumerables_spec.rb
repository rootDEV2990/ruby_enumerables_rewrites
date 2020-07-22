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
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_each_with_index
            test2 = arr.each_with_index
            expect(test1 == test2)
        end
    end

    describe '.my_select' do
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_select { |item| item == 20}
            test2 = arr.select { |item| item == 20}
            expect(test1 == test2)
        end
    end

    describe '.my_any?' do
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_any?(100)
            test2 = arr.any?(100)
            expect(test1 == test2)
        end
    end

    describe '.my_count' do
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_count
            test2 = arr.count
            expect(test1 == test2)
        end
    end

    describe '.my_map' do
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_map
            test2 = arr.map
            expect(test1 == test2)
        end
    end

    describe '.my_inject' do
        it 'Makes self into array unless block is given and adds index too' do
            test1 = arr.my_inject(0) { |total, n| total + n }
            test2 = arr.inject(0) { |total, n| total + n }
            expect(test1 == test2)
        end
    end
end