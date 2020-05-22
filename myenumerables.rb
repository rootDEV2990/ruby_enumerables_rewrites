module Enumerable
  def my_each
    index = 0
    while index < size
      return to_a unless block_given?

      yield self[index]
      index += 1
      self
    end
  end

  def my_each_with_index(index = 0)
    while index < size
      return self unless block_given?

      yield self[index], index
      index += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    result = []
    my_each { |item| result << item if yield(item) == true }
    result
  end

  def my_all?(query = nil)
    my_each do |idx|
      if query.is_a? Class
        return false unless idx.is_a? query
      elsif query.is_a? String or query.is_a? Integer
        return false unless idx == query
      elsif query.is_a? Regexp
        return false unless idx.match(query)
      elsif block_given?
        return false unless yield(idx)
      elsif !empty?
        return false
      end
    end
    true
  end

  def my_any?(*query)
    if !query.empty?
      my_each { |item| return true if item == query }
    elsif block_given?
      my_each { |item| return true if yield(item) }
    else
      my_each { |item| return true if item }
    end
    false
  end

  def my_none?(query = nil)
    if !query.nil?
      to_a.my_each { |item| return false if query == item }
    elsif query.is_a? Class
      my_each { |item| return false if item == query }
    elsif block_given?
      my_each { |item| return false if yield(item) }
    else
      my_each { |item| return false if item }
    end
    true
  end

  def my_count(query = nil)
    count = []
    array = to_a
    if !query.nil?
      array.my_each { |item| count.push(item) if item == query }
      count.length
    else
      array.length
    end
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

  def my_inject(query = nil, query2 = nil)
    array = to_a
    if block_given?
      array.push(query)
      block_return = 1
      array.my_each { |item| block_return = yield(block_return, item) }
      block_return
    elsif query2.nil? and query.is_a? Symbol
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
