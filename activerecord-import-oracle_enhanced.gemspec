require File.expand_path('../lib/activerecord-import-oracle_enhanced/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Félix Bellanger"]
  gem.email         = ["felix.bellanger@gmail.com"]
  gem.summary       = "Bulk insert extension for ActiveRecord and Oracle"
  gem.description   = "A library for bulk inserting data using ActiveRecord and Oracle."
  gem.homepage      = "http://github.com/keeguon/activerecord-import-oracle_enhanced"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "activerecord-import-oracle_enhanced"
  gem.require_paths = ["lib"]
  gem.version       = ActiveRecord::Import::OracleEnhanced::VERSION

  gem.required_ruby_version = ">= 1.9.2"

  gem.add_runtime_dependency "activerecord-import", ">= 0.18"
  gem.add_development_dependency "rake"
end
