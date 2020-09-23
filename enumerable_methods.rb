module Enumerable
  # my_each

  def my_each
    return enum_for(:my_each) unless block_given?
      arr = *self
      i = 0
      while i < arr.length
        yield(arr[i])
        i += 1
      end
    self
  end

  # my_each_with_index

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    arr = *self
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
    self
  end

  # select

  def my_select
    return enum_for(:my_select) unless block_given?

    arr = *self
    new_arr = []
    arr.my_each do |element|
      next unless yield(element)

      new_arr.push(element)
    end
    new_arr
  end

  # my_all?

  def my_all?(arg = nil)
    condition = true
    my_each do |element|
      if arg.is_a?(Integer)
        if element != arg
          condition = false
          break
        end
      end
      if arg.is_a?(Class)
        if element.is_a?(arg) == false
          condition = false
          break
        end
      elsif arg.is_a?(Regexp)
        if element.match?(arg) == false
          condition = false
          break
        end
      else
        if block_given?
          if yield(element) == false || element.nil?
            condition = false
            break
          end
        else
          if element == false || element.nil?
            condition = false
            break
          end
        end
      end
    end
    condition
  end

  # my_any?

  def my_any?(arg = nil)
    condition = false
    my_each do |element|
      if arg.is_a?(Class)
        if element.is_a?(arg)
          condition = true
          break
        end
      elsif arg.is_a?(Regexp)
        if element.match?(arg)
          condition = true
          break
        end
      else
        if block_given?
          if yield(element) || element.nil?
            condition = true
            break
          end
        else
          if element || element.nil?
            condition = true
            break
          end
        end
      end
    end
    condition
  end

  # my_none?

  def my_none?(arg = nil)
    !my_any?(arg)
  end

  # count

  def my_count(arg = nil)
    arr = *self
    if block_given? && arg.nil?
      new_arr = []
      arr.my_each do |element|
        next unless yield(element)

        new_arr.push(element)
      end
      new_arr.length
    elsif (!block_given? && !arg.nil?) || (block_given? && !arg.nil?)
      new_arr = []
      arr.my_each do |element|
        new_arr.push(element) if element == arg
      end
      new_arr.length
    else
      arr.length
    end
  end

  # my_map

  def my_map(my_proc = nil)
    return enum_for(:my_map) unless block_given?

    new_arr = []
    if my_proc
      my_each { |i| new_arr.push my_proc.call(i) }
    else
      my_each { |i| new_arr.push(yield(i)) }
    end
    new_arr
  end

  # my_inject

  def my_inject(arg1 = 0, arg2 = nil)
    return raise LocalJumpError if !block_given? && !arg1

    if block_given?
      result = arg1
      my_each do |element|
        result = yield(result, element)
      end
    elsif !block_given? && arg1 && arg2
      result = arg1
      my_each do |element|
        result = result.send arg2, element
      end
    elsif !block_given? && !arg2
      result = 0
      result = 1 if arg1 == (:* || '*')
      my_each do |element|
        result = result.send arg1, element
      end
    end
    result
  end
end

def multiply_els(arg1 = nil)
  arg1.my_inject(:*)
end


#block = proc { |num| num < 4 }
#range = Range.new(5, 50) 
#puts range.my_each_with_index(&block) === range.each_with_index(&block)

puts [5, 3, 3, 2, 4, 8, 3, 6, 5, 0, 1, 5].my_all?(Float)