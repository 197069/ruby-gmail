# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmail/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-gmail"
  spec.version       = Gmail::VERSION
  spec.authors       = ["dcparker", "myobie"]
  spec.email         = ["me@nathanherald.com"]
  spec.summary       = %q{A rubyesque interface to gmail}
  spec.description   = %q{A rubyesque interface to Gmail, with all the tools you'll need. Search, read and send multipart emails. Archive, mark as read/unread, and delete emails. Manage labels!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
