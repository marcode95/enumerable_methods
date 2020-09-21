
# my_each
module Enumerable
def my_each
  arr = *self   
  i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end  
end


# arr4 = {"name" => "rick", "age" => 7, "hungry" => true}
# arr4.my_each do |x, y| 
#   puts "#{x}" " #{y}"
# end

# my_each_with_index

def my_each_index
  arr = *self   
  i = 0
  while i < arr.length
    yield(arr[i], i)
    i += 1
  end   
end


# arr4 = {"name" => "rick", "age" => 7, "hungry" => true}
# arr4.my_each_index do |element, index|
#   puts element if index.even?
# end



#select

def my_select
  arr = *self  
  new_arr = []
  arr.my_each do |element|
    next unless yield(element)
    new_arr.push(element)
  end
  new_arr  
end


# my_arr = [1, 2, 3, 4, 5, 6]
# my_arr.my_select {|x| x < 5}

# my_all?

def my_all?
  return LocalJumpError unless block_given?
  arr = *self  
  condition = true
  arr.my_each do |element|
    if yield(element) == false
      condition = false
      break
    end
  end
  condition  
end

#my_arr = {"name" => 1, "age" => 7, "hungry" => 4}
#puts my_arr.my_all? {|k, v| v < 5}



# my_any?

def my_any?
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
  

# my_arr = [1, 2, 3, 4, 5, 6]
# puts my_arr.my_any? { |x| x > 2 }


# my_none?

def my_none?  
 return LocalJumpError unless block_given?
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
 

#my_arr = [1, 2, 3, 4, 5, 6]
#puts my_arr.my_none? { |x| x < 3 }



# #count

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


#my_arr = [1, 2, 3, 4, 5]
#my_arr.my_count { |x| x < 3 }



#my_map

def my_map
  arr = *self
  new_arr = []
  arr.my_each do |element|    
    new_arr.push(yield(element))
  end
  new_arr
end
end

my_arr = [1, 2, 3, 4, 5, 6]
p = Proc.new { |x| x + 3 }  
puts p.my_map 


# # my_inject

# def my_inject(arr, start)
#   result = 0 + start
#   my_each(arr) do |element| 
#     result = yield(result, element)
#   end
#   result
# end
# # my_arr = [1, 2, 3, 4, 5, 6]
# # puts my_inject(my_arr, 1){ |sum, number| sum * number }


# end


