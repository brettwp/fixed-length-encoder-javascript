require 'fixed_length_encoder'

class Stats
  def initialize
    @delta_max = 0
    @negative_count = 0
    @one_count = 0
    @iterations = 0
    @average_cumm = 0
    @stddev_cumm = 0
  end

  def add_delta(delta)
    if (delta < 0)
      delta = -delta
      @negative_count += 1
    end
    @one_count += 1 if delta == 1
    @iterations += 1
    @average_cumm += delta
    @stddev_cumm += delta*delta
    @delta_max = delta if delta > @delta_max
  end

  def negative_count
    @negative_count
  end

  def one_count
    @one_count
  end

  def delta_max
    @delta_max
  end

  def average
    @average_cumm / @iterations
  end

  def stddev
    Math.sqrt((@stddev_cumm - (average*average/@iterations))/@iterations)
  end

  def one_percent
    100.0 * @one_count / @iterations
  end

  def negative_percent
    100.0 * @negative_count / @iterations
  end
end

def comma(number)
  number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
end

max = 36**8
iter = 10**7
encoder = FixedLengthEncoder::Encoder.new(FixedLengthEncoder::ALPHABET, FixedLengthEncoder::ENCODE_MAP, FixedLengthEncoder::DECODE_MAP)
random_stats = Stats.new()
encoder_stats = Stats.new()
puts "36**8 = #{comma(max)}"
(0..iter).each do |i|
  value = Random.rand(max - 2)
  e1 = encoder.string_to_integer(encoder.encode(value, 8))
  e2 = encoder.string_to_integer(encoder.encode(value+1, 8))
  encoder_stats.add_delta(e1 - e2)

  v1 = Random.rand(max - 1)
  v2 = Random.rand(max - 1)
  random_stats.add_delta(v1 - v2)
end

def report(title, encoder)
  puts "===#{title}==="
  puts 'Neg: ' + comma(encoder.negative_count) + " (#{encoder.negative_percent.to_s}%)"
  puts 'One: ' + comma(encoder.one_count) + " (#{encoder.one_percent.to_s}%)"
  puts 'Max: ' + comma(encoder.delta_max)
  puts 'Avg: ' + comma(encoder.average)
  puts 'Std: ' + comma(encoder.stddev)
end

report('Random', random_stats)
report('Encoder', encoder_stats)
