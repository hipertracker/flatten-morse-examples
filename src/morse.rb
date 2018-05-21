class Morse
  @@map = {
    'A' => '.-',
    'B' => '-...',
    'C' => '-.-.',
    'D' => '-..',
    'E' => '.',
    'F' => '..-.',
    'G' => '--.',
    'H' => '....',
    'I' => '..',
    'J' => '.---',
    'K' => '-.-',
    'L' => '.-..',
    'M' => '--',
    'N' => '-.',
    'O' => '---',
    'P' => '.--.',
    'Q' => '--.-',
    'R' => '.-.',
    'S' => '...',
    'T' => '-',
    'U' => '..-',
    'V' => '...-',
    'W' => '.--',
    'X' => '-..-',
    'Y' => '-.--',
    'Z' => '--..',
    '0' => '-----',
    '1' => '.----',
    '2' => '..---',
    '3' => '...--',
    '4' => '....-',
    '5' => '.....',
    '6' => '-....',
    '7' => '--...',
    '8' => '---..',
    '9' => '----.',
    '.' => '.-.-.- ',
    ',' => '--..--',
  }
  @@char_separator = '|'
  @@word_separator = '/'

  class << self
    def encode(input, obfuscated = false)
      validation(input)
      text = input.split(/\s+/).map do |word|
        word.split('').map { |char| @@map[char] }
      end.each.map do |word|
        if word.is_a? Array
          word.join(@@char_separator)
        else
          word + @@word_separator
        end
      end.join(@@word_separator)
      obfuscated ? obfuscate(text) : text
    end

    def encode_file(input_filepath, out, obfuscated = true)
      if out.is_a? String
        File.open(out, 'w') do |file|
          process_file(input_filepath, file, obfuscated)
        end
      else
        process_file(input_filepath, out, obfuscated)
      end
    end

    private

    def process_file(input_filepath, out, obfuscated)
      File.open(input_filepath, 'r').each do |line|
        out.write encode(line, obfuscated)
        out.write("\n") if line[-1] == "\n"
      end
    end

    def validation(input)
      allowed_chars = @@map.keys
      diff = input.gsub(/\s+/, '').split('').uniq - allowed_chars
      unless diff.empty?
        raise ArgumentError.new "Wrong chars: #{diff.join(' ')}"
      end
    end

    def obfuscate(text)
      offset = 'A'.ord - 1
      text.gsub(/(\.+)/) { $1.size }.gsub(/(-+)/) { ($1.size + offset).chr }
    end
  end
end

