require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'flatten'

describe "flatten()" do
  it "should return unchanged array if it's not nested" do
    assert_equal [1, 2, 3, 4, 5], flatten([1, 2, 3, 4, 5])
  end

  it 'should flatten a single nested array' do
    assert_equal [1, 2, 3, 4, 5], flatten([1, 2, [3, 4], 5])
  end

  it 'should flatten several nested arrays' do
    given = flatten([1, 2, [3, 4, [5, 6, [7, 8, 9]]], [10, 11], 12])
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], given
  end

  it 'should flatten a single multi nested array' do
    assert_equal [1], flatten([[[[[1]]]]])
  end

  it 'should accept empty array' do
    assert_equal [], flatten([])
  end

  it 'should not accept wrong parameter type' do
    begin
      flatten(array: 'Wrong type')
    rescue ArgumentError => error
      assert_equal "Array required!", error.message
    end
  end
end

describe "flatten2()" do
  it 'should return unchanged not nested array' do
    assert_equal [1, 2, 3, 4, 5], flatten2([1, 2, 3, 4, 5])
  end

  it 'should flatten a single nested array' do
    assert_equal [1, 2, 3, 4, 5], flatten2([1, 2, [3, 4], 5])
  end

  it 'should flatten several nested arrays' do
    given = flatten2([1, 2, [3, 4, [5, 6, [7, 8, 9]]], [10, 11], 12])
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], given
  end

  it 'should flatten a single multi nested array' do
    assert_equal [1], flatten2([[[[[1]]]]])
  end

  it 'should accept empty array' do
    assert_equal [], flatten2([])
  end

  it 'should not accept wrong parameter type' do
    begin
      flatten2(array: 'Wrong type')
    rescue ArgumentError => error
      assert_equal "Array required!", error.message
    end
  end

end