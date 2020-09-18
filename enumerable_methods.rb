# each

def my_each(arr)
  if arr.kind_of?(Array) == true 
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end  
  else    
    i = 0
    while i < arr.length
    yield(arr.keys[i], arr.values[i])
    i += 1
    end  
  end  
end

=begin
rescue => exception
  
end my_each(["name", "eric", 6, "hungry"]) do |x| 
  puts "#{x}" 
end

my_each({"name" => "rick", "age" => 7, "hungry" => true}) do |x, y|
  puts "#{x}" " #{y}" 
end
=end


#each_with_index

def my_each_index(arr)
  if arr.kind_of?(Array) == true 
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end  
  else    
    i = 0
    while i < arr.length
    yield(arr.keys[i], arr.values[i], i)
    i += 1
    end  
  end  
end

=begin
my_arr = [1, 2, 3, 4, 5, 6]
my_hash = {"name" => "rick", "age" => 7, "hungry" => true}

my_each_index(my_arr) do |element, index|
  puts element if index.even?
end

my_each_index(my_hash) do |key, value, index|
  puts "#{key}" " #{value}" if index.even?
end
=end


#select

def my_select(arr)
  new_arr = []
  my_each(arr) do |element|
    next unless yield(element)
    new_arr.push(element)
  end
  puts new_arr
end

#my_arr = [1, 2, 3, 4, 5, 6]
#my_select(my_arr){ |x| x != 3 }



# my_all?

def my_all?(arr)  
  my_each(arr) do |element|
    return false unless yield(element)
    return true
  end
end    

# my_arr = [1, 2, 3, 4, 5, 6]
# puts my_all?(my_arr){ |x| x > 0 }



# my_any?

def my_any?(arr)
  condition = false  
  my_each(arr) do |element|
    if yield(element)
      condition = true
      break
    end
  end
  condition
end  

#my_arr = [1, 2, 3, 4, 5, 6]
#puts my_any?(my_arr){ |x| x >  6 }



# my_none?

def my_none?(arr)  
  my_each(arr) do |element|
    return true unless yield(element)
    return false
  end
end    

#my_arr = [1, 2, 3, 4, 5, 6]
#puts my_none?(my_arr){ |x| x > 3 }



#count

def my_count(arr)
  if block_given?
    new_arr = []
    my_each(arr) do |element|
      next unless yield(element)
      new_arr.push(element)
    end
    puts new_arr.length
  else
    puts arr.length
  end
end

# my_arr = [1, 2, 3, 4, 5]
# my_count(my_arr) 



#my_map

def my_map(arr)
  new_arr = []
  my_each(arr) do |element|    
    new_arr.push(yield(element))
  end
  new_arr
end

# my_arr = [1, 2, 3, 4, 5, 6]
# puts my_map(my_arr){ |x| x + 3 }


# my_inject

def my_inject(arr, start)
  result = 0 + start
  my_each(arr) do |element| 
    result = yield(result, element)
  end
  result
end
# my_arr = [1, 2, 3, 4, 5, 6]
# puts my_inject(my_arr, 1){ |sum, number| sum * number }


