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
    arr
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
    arr
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
          if yield(element) == false || element == nil
            condition = false
            break
          end
        else        
          if element == false || element == nil
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
          if yield(element) || element == nil
            condition = true
            break
          end
        else        
          if element || element == nil
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
    if block_given? && arg == nil
      new_arr = []
      arr.my_each do |element|
        next unless yield(element)
        new_arr.push(element)
      end
      new_arr.length
    elsif (!block_given? && arg != nil) || (block_given? && arg != nil)
      new_arr = []
      arr.my_each do |element|
        if element == arg
          new_arr.push(element)
        end
      end
      new_arr.length
    else 
      arr.length
    end
  end

  # my_map

  def my_map(my_proc = nil)
    return enum_for(:my_map
    ) unless block_given?
    new_arr = []
    if my_proc
      my_each { |i| new_arr.push my_proc.call(i) }
    else
      my_each { |i| new_arr.push(yield(i)) }
    end
    new_arr
  end

  # my_inject

  def my_inject(arg1 = nil, arg2 = nil)
    return raise LocalJumpError unless block_given? && !arg1
    result = 0 + arg1
    my_each do |element|
      result = yield(result, element)
    end
    result
  end  
end

my_arr = [1, 2, 3, 4, 5, 6]
puts my_arr.my_inject(0){ |sum, number| sum + number }


# multiply_els

def multiply_els
  arr = *self
  arr.my_inject(1) { |sum, number| sum * number }
end


# #p [1, 2, 3].my_all? {|x| puts x}
# p ["an", "bear", "ca"].my_all?(/t/)
# p ["an", "bear", "ca"].my_any?(/t/)
# p ["an", "bear", "ca"].my_none?(/t/)

# #p {"name" => 1, "age" => 7, "hungry" => 4}.my_all? {|k, v| v > 3}


# my_arr = [1,2,nil,4,5,56]
# #puts my_arr.my_all?

my_arr = [1, 2, 3, 2, 5]
p my_arr.my_count(2) { |x| x < 3 }




