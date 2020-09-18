require './lib/method-result-caching.rb'

class Foo
  def initialize(x)
    @x = x
  end

  def calculate_something
    puts "called #{__method__}"
    @x + 10
  end
  cache_result_for :calculate_something
end

foo_01 = Foo.new(10)
puts foo_01.calculate_something
puts foo_01.calculate_something
foo_01.clear_cached_result_for!(:calculate_something)
puts foo_01.calculate_something
puts foo_01.calculate_something
