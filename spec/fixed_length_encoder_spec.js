var FixedLengthEncoder = require('../lib/fixed_length_encoder.js');

describe('FixedLengthEncoder', () => {
  var fle;

  describe('Invalid encodings', () => {
    beforeEach(() => {
      fle = new FixedLengthEncoder();
      fle.ALPHABET = '0123456789';
    });

    it('should error on non-integers', () => {
      expect(() => fle.encode('ERROR')).toThrow();
    });

    it('shouldn\'t encode values too big for message length', () => {
      expect(() => fle.encode(100, 2)).toThrow();
    });

    it('shouldn\'t encode negative values', () => {
      expect(() => fle.encode(-1, 2)).toThrow();
    });

    it('should error for non-strings', () => {
      expect(() => fle.decode(0)).toThrow();
    });

    it('should error for bad characters', () => {
      expect(() => fle.decode('^')).toThrow();
    });
  });

  describe('Valid encodings', () => {
    function shuffle(a) {
      for(var i = 0; i < a.length; i++) {
        var r = Math.floor(Math.random() * (i + 1));
        var t = a[i];
        a[i] = a[r];
        a[r] = t;
      }
      return a;
    }

    beforeEach(() => {
      fle = new FixedLengthEncoder();
      fle.ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var max = 62*62 - 1;
      var encode_map = shuffle(Array(max + 1).fill().map((x,i) => i));
      var decode_map = [];
      encode_map.forEach((cv, i) => decode_map[cv] = i);
      fle.ENCODE_MAP = encode_map
      fle.DECODE_MAP = decode_map
    });

    it('should be a valid alphabet', () => {
      expect(fle.isValidAlphabet()).toBe(true);
    });

    it('should be a valid map', () => {
      expect(fle.isValidMap()).toBe(true);
    });

    it('should be reversible for the min value', () => {
      var value = 0;
      var message = fle.encode(value);
      expect(fle.decode(message)).toEqual(value);
    });

//     it('should be reversible for the max value', () => {
//       value = (62**8)-1
//       message = fle.encode(value)
//       fle.decode(message).toEqual(value)
//     });

//     it('should be reversible for the middle value', () => {
//       value = ((62**8)/2).floor
//       message = fle.encode(value)
//       fle.decode(message).toEqual(value)
//     });
//   });

//   describe 'Default encodings' do
//     it('should be a valid alphabet', () => {
//       fle.isValidAlphabet().should be_true
//     });

//     it('should be a valid map', () => {
//       fle.isValidMap().should be_true
//     });

//     it('should be reversible for the min value', () => {
//       value = 0
//       message = fle.encode(value)
//       fle.decode(message).toEqual(value)
//     });

//     it('should be reversible for the max value', () => {
//       value = (36**8)-1
//       message = fle.encode(value)
//       fle.decode(message).toEqual(value)
//     });

//     it('should be reversible for the middle value', () => {
//       value = ((36**8)/2).floor
//       message = fle.encode(value)
//       fle.decode(message).should eq(value)
//     });
  });
});
