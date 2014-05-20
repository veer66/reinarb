Gem::Specification.new do |s|
  s.name        = 'reina'
  s.version     = '0.0.3'
  s.date        = '2014-05-20'
  s.summary     = "A toolset for Apertium written in Ruby"
  s.description = "Reina.rb is a toolset for Apertium written in Ruby"
  s.authors     = ["Vee Satayamas"]
  s.email       = 'v.satayamas@gmail.com'
  s.files       = ["lib/reina/stream_parser.rb", "lib/reina/ldix_loader.rb"]
  s.homepage    =
    'https://github.com/veer66/reinarb'
  s.license       = 'MIT'
  s.add_dependency("whittle", "0.0.8")
end
