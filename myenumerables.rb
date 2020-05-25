module Enumerable
  def my_each
    index = 0
    while index < size
      return to_enum(:my_each) unless block_given?

      yield self[index]
      index += 1
      return self
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
        return false unless !idx.nil?
      end
    end
    true
  end

  def my_any?(*query)
    if block_given?
      length.times { |item| return true if yield(item) }
    elsif query.class == Regexp
      length.times { |item| return true if item == query }
    elsif query.class == Class
      length.times { |item| return true if item.class == query }
    elsif query.class == Numeric or query.class == String
      length.times { |item| return true if item == query }
    else
      length.times { |item| return true if item }
    end
    false
  end

  def my_none?(*query)
    if block_given?
      length.times { |item| return false if yield(item) }
    elsif query.class == Regexp
      length.times { |item| return false if item == query }
    elsif query.class == Class
      length.times { |item| return false if item.class == query }
    elsif query.class == Numeric or query.class == String
      length.times { |item| return false if item == query }
    else
      length.times { |item| return false if item }
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

  def my_map
    return to_enum unless block_given?

    array = []
    if block_given?
      to_a.my_each do |item|
        array.push(yield(item))
      end
    end
    array
  end

  def my_inject(query = nil)
    array = to_a
    block_return = ''.to_i
    if block_given?
      block_return = array.shift
      for item in array do
        block_return = yield(block_return, item)
      end
      block_return
    elsif query.class == Symbol
      array.reduce(0) { |sum, num| sum << num.public_send(query, num + 1) }
      sum
    else
      array.push(query)
      array
    end
  end

  def multiply_els(array)
    array.to_a.my_inject(1) { |a, b| a * b }
  end
end
