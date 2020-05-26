module Enumerable
  def my_each
    index = 0
    array = to_a
    if block_given?
      for item in 0..array.length - 1
        yield(self[item])
      end
    else
      while index < array.size
        return to_enum(:my_each) unless block_given?

        yield self[index]
        index += 1
        return self
      end
    end
  end

  def my_each_with_index(index = 0)
    while index < size
      return to_enum(:my_each_with_index) unless block_given?

      yield self[index], index
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |item| result << item if yield(item) == true }
    result
  end

  def my_all?(query = nil)
    if query.class == Class
      my_each do |idx|
        return false unless idx.class == query
      end
    elsif query.class == String or query.class == Integer
      my_each do |idx|
        return false unless idx == query
      end
    elsif query.class == Regexp
      my_each do |idx|
        return false unless idx.match(query)
      end
    elsif block_given?
      my_each do |idx|
        return false unless yield(idx)
      end
    elsif query.nil?
      my_each do |idx|
        return false if idx === false
      end
    else
      my_each do |idx|
        return false unless !idx.nil?
      end
    end
    true
  end

  def my_any?(*query)
    if block_given?
      length.times { |item| return true unless yield(item) }
    elsif query.class == Regexp
      length.times { |item| return true unless item == query }
    elsif query.class == Class
      length.times { |item| return true unless item.class == query }
    elsif query.class == Numeric or query.class == String
      length.times { |item| return true unless item == query }
    elsif query.class == Proc
      length.times { |item| return true unless yield(item) }
    else
      length.times { |item| return true unless item }
    end
    false
  end

  def my_none?(*query)
    if block_given?
      length.times { |item| return false unless yield(item) }
    elsif query.class == Regexp
      length.times { |item| return false unless item == query }
    elsif query.class == Class
      length.times { |item| return false unless item.class == query }
    elsif query.class == Numeric or query.class == String
      length.times { |item| return false unless item == query }
    else
      length.times { |item| return false unless item }
    end
    true
  end

  def my_count(query = nil)
    array = self
    count = 0
    if block_given?
      array.length.times { |item| count += 1 if yield(array[item]) }
    elsif !query.nil?
      array.length.times { |item| count += 1 if array[item] == query }
    elsif query.nil?
      count = array.length
    end
    count
  end

  def my_map(query = nil)
    if query.nil?
      array = []
      to_a.my_each do |item|
        array.push(yield(item)) if block_given?
      end
      array
    elsif query.class == Proc or block_given?
      array = []
      my_each do |item|
        array << query.call(item)
      end
      array
    else
      return to_enum :my_map unless block_given?
    end
  end

  def my_inject(query = nil, query2 = nil)
    array = to_a
    block_return = ''.to_i
    if block_given? and query.nil?
      block_return = array.shift
      for item in array do
        block_return = yield(block_return, item)
      end
      block_return
    elsif block_given? and query2.nil? and query.class == Integer
      array.push(query)
      block_return = array.shift
      for item in array do
        block_return = yield(block_return, item)
      end
      block_return
    elsif query2.class == Symbol
      sum = query
      array.my_each do |item|
        sum = sum.public_send(query2, item)
      end
      sum
    elsif query.class == Symbol
      array = array.reduce(0) do |sum, num|
        sum = sum.public_send(query, num)
      end
      array
    else
      array.push(query)
      array
    end
  end

  def multiply_els(array)
    array.to_a.my_inject(1) { |a, b| a * b }
  end
end
