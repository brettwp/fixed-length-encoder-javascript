require 'fixed_length_encoder'

def suppress_warnings
  original_verbosity = $VERBOSE
  $VERBOSE = nil
  result = yield
  $VERBOSE = original_verbosity
  return result
end

describe FixedLengthEncoder do
  describe 'Invalid encodings' do
    before (:each) do
      suppress_warnings do
        @origianl = FixedLengthEncoder::ALPHABET
        FixedLengthEncoder::ALPHABET = '0123456789'
      end
    end

    after (:each) do
      suppress_warnings do
        FixedLengthEncoder::ALPHABET = @origianl
      end
    end

    it 'should error on non-integers' do
      expect { FixedLengthEncoder.encode('ERROR') }.to raise_error(ArgumentError)
    end

    it 'shouldn\'t encode values too big for message length' do
      expect { FixedLengthEncoder.encode(100, 2) }.to raise_error(ArgumentError)
    end

    it 'shouldn\'t encode negative values' do
      expect { FixedLengthEncoder.encode(-1, 2) }.to raise_error(ArgumentError)
    end

    it 'should error for non-strings' do
      expect { FixedLengthEncoder.decode(0) }.to raise_error(ArgumentError)
    end

    it 'should error for bad characters' do
      expect { FixedLengthEncoder.decode('^') }.to raise_error(ArgumentError)
    end
  end

  describe 'Valid encodings' do
    before (:each) do
      suppress_warnings do
        @origianl = FixedLengthEncoder::ALPHABET
        @encode_map = FixedLengthEncoder::ENCODE_MAP
        @decode_map = FixedLengthEncoder::DECODE_MAP
        FixedLengthEncoder::ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
        max = 62*62 - 1
        encode_map = (0..max).to_a.shuffle
        decode_map = []
        (0..max).each { |i| decode_map[encode_map[i]] = i }
        FixedLengthEncoder::ENCODE_MAP = encode_map
        FixedLengthEncoder::DECODE_MAP = decode_map
      end
    end

    after (:each) do
      suppress_warnings do
        FixedLengthEncoder::ALPHABET = @origianl
        FixedLengthEncoder::ENCODE_MAP = @encode_map
        FixedLengthEncoder::DECODE_MAP = @decode_map
      end
    end

    it 'should be a valid alphabet' do
      FixedLengthEncoder.isValidAlphabet().should be_true
    end

    it 'should be a valid map' do
      FixedLengthEncoder.isValidMap().should be_true
    end

    it 'should be reversible for the min value' do
      value = 0
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end

    it 'should be reversible for the max value' do
      value = (62**8)-1
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end

    it 'should be reversible for the middle value' do
      value = ((62**8)/2).floor
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end
  end

  describe 'Default encodings' do
    it 'should be a valid alphabet' do
      FixedLengthEncoder.isValidAlphabet().should be_true
    end

    it 'should be a valid map' do
      FixedLengthEncoder.isValidMap().should be_true
    end

    it 'should be reversible for the min value' do
      value = 0
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end

    it 'should be reversible for the max value' do
      value = (36**8)-1
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end

    it 'should be reversible for the middle value' do
      value = ((36**8)/2).floor
      message = FixedLengthEncoder.encode(value)
      FixedLengthEncoder.decode(message).should eq(value)
    end
  end
end
