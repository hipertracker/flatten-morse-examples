## Note:

The code was written in Ruby 2.5.1 but it should work in older versions as well. For unit test I used `minitest` which is a part of Ruby standard library.

### Flatten nested array

`flatten(data)` - return a a new flatten array

`flatten(array: data)` - as above

`flatten2(array)` - as above but the implementation does not use the recursion (bonus)

Both functions are _pure_, they don't change the source array. 

### Morse Code encoder

`Morse.encode(text)` - return Morse code with defined char and word separators

`Morse.encode(text, true)` - as above but obfuscated

`Morse.encode(text, obfuscated: true)` - as above 

`Morse.encode_file(input_path, output)` - create a file with obfuscated (default) Morse code. The `output` parameter can be an output file path or a File object:

```ruby
File.open('out.txt', 'w') do |file|
  Morse.encode_file('in.txt', file)
end
```

## Test:

```rake```
