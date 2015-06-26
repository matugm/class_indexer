# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'class_indexer/version'

Gem::Specification.new do |spec|
  spec.name          = "class_indexer"
  spec.version       = ClassIndexer::VERSION
  spec.authors       = ["matugm"]
  spec.email         = ["matugm@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Index all methods and output json.}
  spec.description   = %q{Reads ruby files in the current directory to produce a json index of methods and classes. Use the 'indexer' command to run.}
  spec.homepage      = "http://www.blackbytes.info"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "parser"
  spec.add_dependency "json"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
