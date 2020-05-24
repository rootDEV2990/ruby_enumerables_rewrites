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
    if block_given?
      to_a.length.times { |item| return true if yield(item) }
    elsif query.is_a? Regexp
      to_a.length.times { |item| return true if item == query }
    elsif query.is_a? Class
      to_a.length.times { |item| return true if item.is_a?(query) }
    elsif query.is_a? Numeric or query.is_a? String
      to_a.length.times { |item| return true if item == query }
    else
      to_a.length.times { |item| return true if item }
    end
    false
  end

  def my_none?(*query)
    if block_given?
      length.times { |item| return false if yield(item) }
    elsif query.is_a? Regexp
      length.times { |item| return false if item == query }
    elsif query.is_a? Class
      length.times { |item| return false if item.is_a?(query) }
    elsif query.is_a? Numeric or query.is_a? String
      length.times { |item| return false if item == query }
    else
      length.times { |item| return false if item }
    end
    true
  end

  def my_count(query = nil)
    count = []
    array = to_a
    if block_given?
      self.length.times do |item| 
        count.push(item) if yield(item)
      end
      p count.length-1
    elsif !query.nil?
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

  def my_inject(arg1 = nil, arg2 = nil)
    obj = self
    obj = obj.to_a unless obj.is_a?(Array)
    result = 0
    result = arg1 if arg1.is_a?(Numeric)
    result = '' if obj[0].is_a?(String)
    if block_given?
      length.times { |i| result = yield(result, i) }
    elsif arg1.is_a?(Symbol)
      length.times { |i| result = result.send(arg1, i) }
    else
      length.times { |i| result = result.send(arg2, i) }
    end
    result
  end

  def multiply_els(array)
    array.to_a.my_inject(1) { |a, b| a * b }
  end
end
