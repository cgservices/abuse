$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'abuse/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'abuse'
  s.version     = Abuse::VERSION
  s.authors     = ['Mark Kampstra']
  s.email       = ['info@cg.nl']
  s.homepage    = 'https://github.com/cgservices/abuse'
  s.summary     = 'Abuse gem'
  s.description = 'Track abusive actions'
  s.license     = 'MIT'

  s.files =
    Dir[
        '{app,config,db,lib}/**/*',
        'MIT-LICENSE',
        'Rakefile',
        'README.md',
        'CHANGELOG.md'
  ]
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.2.8'

  s.add_development_dependency 'sqlite3'

  # Rubocop
  s.add_development_dependency 'rubocop', '~> 0.47'
  s.add_development_dependency 'rubocop-checkstyle_formatter', '~> 0.3'

  # Rspec + code coverage
  s.add_development_dependency 'reek', '~> 4.5'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'rspec-rails', '~> 3.5'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.2'
  s.add_development_dependency 'faker', '~> 1.7.3'
  s.add_development_dependency 'simplecov', '~> 0.13'
  s.add_development_dependency 'simplecov-rcov', '~> 0.2'
  s.add_development_dependency 'database_cleaner', '~> 1.3'
  s.add_development_dependency 'email_spec', '~> 2.1'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5.0'
  s.add_development_dependency 'launchy', '~> 2.4'
  s.add_development_dependency 'poltergeist', '~> 1.13'
  s.add_development_dependency 'rspec-activemodel-mocks', '~> 1.0'
  s.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
  s.add_development_dependency 'rspec-its', '~> 1.2'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1'
  s.add_development_dependency 'terminal-notifier-guard', '~> 1.7.0'
end
