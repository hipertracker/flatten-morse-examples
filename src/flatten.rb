#recursive
def flatten(array)
  raise ArgumentError.new "Array required!" unless array.is_a? Array
  result = []
  array.each do |item|
    if item.is_a? Array
      result += flatten(item)
    else
      result << item
    end
  end
  result
end

# non recursive
def flatten2(array)
  raise ArgumentError.new "Array required!" unless array.is_a? Array
  items = Marshal::load(Marshal.dump(array)) # deep clone
  result = []
  while items.length > 0
    item = items.shift
    if item.is_a? Array
      items = item + items
    else
      result << item
    end
  end
  result
end

