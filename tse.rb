require './myenumerables.rb'

test_array1 = [11, 2, 3, 56]
test_array2 = %w[a b c d]
test_array3 = %w[f g h i]

# my_each
p 'my_each'
p "my each method 1"
p [1,2,3,4,5,6].my_each 
p "with block 1"
p [1,2,3,4,5,6].my_each{|a| a}


p "my each method 2"
p [1,2,3,4,5,6].each
p "with block 2"
p [1,2,3,4,5,6].each{|a| a}
p "end"



# my_each_with_index
p 'my_each-with_index'
p [1,2,3,4,5,6].my_each_with_index
p 'each-with_index'
p [1,2,3,4,5,6].each_with_index

# my_select
p [nil, true, 99].my_any?(Integer) 
p [nil, true, 99].any?(Integer)

#my_none
p [1, 3.14, 42].my_none?(Float) 
p [1, 3.14, 42].none?(Float)

#my_count
array = [1, 2, 3, 4, 5]
p "count"
block = proc { |num| num < 4 }
array.my_count(&block)
