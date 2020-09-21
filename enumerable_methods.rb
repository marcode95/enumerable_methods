module Enumerable
  # my_each

  def my_each
    arr = *self
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
  end

  # my_each_with_index

  def my_each_index
    arr = *self
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
  end

  # select

  def my_select
    arr = *self
    new_arr = []
    arr.my_each do |element|
      next unless yield(element)

      new_arr.push(element)
    end
    new_arr
  end

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
    return LocalJumpError unless block_given?

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

  # multiply_els

  def multiply_els
    arr = *self
    arr.my_inject(1) { |sum, number| sum * number }
  end
end
