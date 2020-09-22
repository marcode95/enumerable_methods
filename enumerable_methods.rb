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

  def my_all?(arg)
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

  def my_any?
    return true unless block_given?
    arr = *self
    condition = false
    arr.my_each do |element|
      if yield(element)
        condition = true
        break
      end
    end
    condition
  end

  # my_none?

  def my_none?
    return true unless block_given?
    arr = *self
    condition = true
    arr.my_each do |element|
      if yield(element) == true
        condition = false
        break
      end
    end
    condition
  end

  # count

  def my_count
    arr = *self
    if block_given?
      new_arr = []
      arr.my_each do |element|
        next unless yield(element)

        new_arr.push(element)
      end
      puts new_arr.length
    else
      puts arr.length
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

  def my_inject(arg1)
    arr = *self
    return LocalJumpError unless block_given?

    result = 0 + arg1
    arr.my_each do |element|
      result = yield(result, element)
    end
    result
  end  
end

# multiply_els

def multiply_els
  arr = *self
  arr.my_inject(1) { |sum, number| sum * number }
end


p ["ant", "beart", "cat"].my_all?(/t/)

#p {"name" => 1, "age" => 7, "hungry" => 4}.my_all? {|k, v| v > 3}


my_arr = [1,2,nil,4,5,56]
#puts my_arr.my_all?



