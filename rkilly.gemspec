Gem::Specification.new do |s|
  s.name        = "rkilly"
  s.version     = "0.0.2"
  s.summary     = "Easily kill processes"
  s.date        = "2014-07-22"
  s.description = "Provides a kill command which finds all processes that match the provided argument and allows you to kill any specific match or all matches."
  s.authors     = ["Christopher Berube"]
  s.email       = ["cberube@adharmonics.com"]
  s.license     = "MIT"
  s.homepage    = "https://github.com/crberube/rkilly"
  s.files       = ["lib/rkilly.rb"]
  s.executables = "rkilly"
  
  s.add_runtime_dependency("commander", "~> 4.2")
end
