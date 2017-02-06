# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geodistance_arel'

Gem::Specification.new do |spec|
  spec.name = 'geodistance_arel'
  spec.version = GeoDistanceArel::VERSION
  spec.authors = ['Rubens Minoru Andako Bueno', 'Bruno Da Silva Assis']
  spec.email = ['rubensmabueno@hotmail.com', 'brunoassis@gmail.com']

  spec.summary =
    'A simple implementation of a Arel field to calculate GeoDistances.'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'arel', '>= 7.0'
  spec.add_dependency 'activesupport', '>= 5.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
