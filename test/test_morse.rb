require 'fileutils'
require 'tempfile'

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'morse'

describe "Morse.new(text).encode" do
  it 'should allow empty string' do
    assert_equal '', Morse.encode('', obfuscated: true)
  end

  it 'should not allow invalid chars' do
    begin
      Morse.encode 'I HAS SOME invalid CHARACTERS'
    rescue ArgumentError => error
      assert_equal "Wrong chars: i n v a l d", error.message
    end
  end

  it 'should return unobfuscated code if not required' do
    text = 'I AM IN TROUBLE'
    expected = "../.-|--/..|-./-|.-.|---|..-|-...|.-..|."
    assert_equal expected, Morse.encode(text)
  end

  it 'should return obfuscated code if required' do
    text = 'I AM IN TROUBLE'
    expected = '2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1'
    assert_equal expected, Morse.encode(text, obfuscated: true)
  end

  it "should process external file" do
    file = Tempfile.new('test')
    begin
      Morse.encode_file('mock/message.txt', file)
      file.rewind # necessary
      assert_equal true, FileUtils.compare_file('mock/encoded_message.txt', file)
    ensure # good practise is to clear tmp files whatever happens
      file.close
      file.unlink
    end
  end

  # This also works but for the testing it's better to use a tmp volatile file
  it "should process external filepath" do
    Morse.encode_file('mock/message.txt', 'mock/tmp.txt')
    assert_equal true, FileUtils.compare_file('mock/encoded_message.txt', 'mock/tmp.txt')
  end if false # do not run this code

end
