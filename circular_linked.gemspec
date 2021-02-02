Gem::Specification.new do |s|
  s.name        = 'circular_linked'
  s.version     = '0.1.2'
  s.summary     = 'Circular Linked List implementation'
  s.description = 'Provides a circular linked list data structure for Ruby with the most common methods'
  s.authors     = ['Gabriela Guedes']
  s.email       = 'gabriela.guedes.gmg@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/GabrielaGuedes/circular_linked'
  s.license       = 'MIT'

  s.add_development_dependency "bundler", '>= 2.0', '< 3.0'
  s.add_development_dependency "rspec", '~> 3.10'
end