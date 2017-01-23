# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'permitify/version'

Gem::Specification.new do |spec|
  spec.name          = "permitify"
  spec.version       = Permitify::VERSION
  spec.authors       = ["Wyatt Kirby"]
  spec.email         = ["wyatt@apsis.io"]

  spec.summary       = %q{A ruby gem for adding permissions to rolify.}
  spec.homepage      = "http://apsis.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
