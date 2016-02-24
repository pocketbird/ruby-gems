# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "csscss"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zach Moazeni"]
  s.date = "2013-06-22"
  s.description = "csscss will parse any CSS files you give it and let you know which rulesets have duplicated declarations."
  s.email = ["zach.moazeni@gmail.com"]
  s.executables = ["csscss"]
  s.files = ["bin/csscss"]
  s.homepage = "http://zmoazeni.github.io/csscss/"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubygems_version = "2.0.14"
  s.summary = "A CSS redundancy analyzer that analyzes redundancy."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parslet>, ["~> 1.5"])
      s.add_runtime_dependency(%q<colorize>, [">= 0"])
    else
      s.add_dependency(%q<parslet>, ["~> 1.5"])
      s.add_dependency(%q<colorize>, [">= 0"])
    end
  else
    s.add_dependency(%q<parslet>, ["~> 1.5"])
    s.add_dependency(%q<colorize>, [">= 0"])
  end
end
