require 'fixed_length_encoder'

puts FixedLengthEncoder.encode(100)
puts FixedLengthEncoder.encode(101)
puts FixedLengthEncoder.encode(42, 3)

max = 7*7 - 1
ENCODE_MAP = (0..max).to_a.shuffle
DECODE_MAP = []
(0..max).each { |i| DECODE_MAP[ENCODE_MAP[i]] = i }
puts "[#{ENCODE_MAP.join(', ')}]"
puts "[#{DECODE_MAP.join(', ')}]"
