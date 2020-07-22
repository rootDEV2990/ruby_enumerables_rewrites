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
end