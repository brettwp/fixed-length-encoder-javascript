# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'fixed_length_encoder'
  spec.version       = FixedLengthEncoder::VERSION
  spec.authors       = ['Brett Pontarelli']
  spec.email         = ['brett@paperyfrog.com']
  spec.description   = 'Integers are converted to strings using a complex mapping ' +
                       'and a base 36 alphabet.  Strings with valid digits (0-9 a-z)' +
                       'are converted back to integers.  The encoding is one-to-one but not sequential.' +
                       'This is useful for obfuscating user ids in urls.'
  spec.summary       = 'Two way conversion from integer to a fixed (default=8) digit string.'
  spec.homepage      = 'http://rubygems.org/gems/fixed_length_encoder'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
