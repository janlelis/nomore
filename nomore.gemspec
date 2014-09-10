# -*- encoding: utf-8 -*-

require File.expand_path('../lib/nomore/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "nomore"
  gem.version       = Nomore::VERSION
  gem.summary       = 'Rewrites a domain to 127.0.0.1 in your /etc/hosts file.'
  gem.description   = 'Quickly rewrites a domain to 127.0.0.1 in your /etc/hosts file, so you can concentrate better.'
  gem.license       = "MIT"
  gem.authors       = ["Jan Lelis"]
  gem.email         = "mail@janlelis.de"
  gem.homepage      = "https://github.com/janlelis/nomore"

  gem.files         = Dir['{**/}{.*,*}'].select { |path| File.file?(path) }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
