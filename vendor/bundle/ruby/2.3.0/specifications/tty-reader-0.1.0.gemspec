# -*- encoding: utf-8 -*-
# stub: tty-reader 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tty-reader".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Murach".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-08-30"
  s.description = "Provides a set of methods for processing keyboard input in character, line and multiline modes. In addition it maintains history of entered input with an ability to recall and re-edit those inputs and register to listen for keystrokes.".freeze
  s.email = ["".freeze]
  s.homepage = "https://piotrmurach.github.io/tty".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Provides a set of methods for processing keyboard input in character, line and multiline modes.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<wisper>.freeze, ["~> 2.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    else
      s.add_dependency(%q<wisper>.freeze, ["~> 2.0.0"])
      s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<wisper>.freeze, ["~> 2.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["< 2.0", ">= 1.5.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
