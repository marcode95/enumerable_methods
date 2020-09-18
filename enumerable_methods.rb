# for array

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

my_each(["name", "eric", 6, "hungry"]) do |x| 
  puts "#{x}" 
end

my_each({"name" => "rick", "age" => 7, "hungry" => true}) do |x, y|
  puts "#{x}" " #{y}" 
end

