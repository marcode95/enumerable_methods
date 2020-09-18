
def my_each(arr)
  i = 0
  while i < arr.length
    yield(arr[i])
    i += 1
  end  
end



my_each({"name" => "eric", "age" => 26, "hungry" => true}) do |x, y| 
  puts "#{x}" "#{y}"
end

restaurant_menu = { "Ramen" => 3, "Dal Makhani" => 4, "Coffee" => 2 }
 restaurant_menu.my_each do | item, price | puts "#{item}: $#{price}" end 