# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bitters"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Fiedler", "Reda Lemeden", "Tyson Gach", "Will McMahan"]
  s.date = "2015-01-29"
  s.description = "Bitters helps designers start projects faster by defining a basic set of Sass\nvariables, default element style and project structure. It\u{2019}s been specifically\ndesigned for use within web applications. Bitters should live in your project\u{2019}s\nroot Sass directory and we encourage you to modify and extend it to meet your\ndesign and brand requirements.\n"
  s.email = "design+bourbon@thoughtbot.com"
  s.executables = ["bitters"]
  s.files = ["bin/bitters"]
  s.homepage = "http://bitters.bourbon.io"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Scaffold styles, variables and structure for Bourbon projects."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<bourbon>, [">= 3.2"])
      s.add_runtime_dependency(%q<sass>, [">= 3.2"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bourbon>, [">= 3.2"])
      s.add_dependency(%q<sass>, [">= 3.2"])
      s.add_dependency(%q<thor>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bourbon>, [">= 3.2"])
    s.add_dependency(%q<sass>, [">= 3.2"])
    s.add_dependency(%q<thor>, [">= 0"])
  end
end
