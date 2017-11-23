# -*- encoding: utf-8 -*-
# stub: ruby-trello 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-trello".freeze
  s.version = "2.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Tregunna".freeze]
  s.date = "2017-02-05"
  s.description = "A wrapper around the trello.com API.".freeze
  s.email = "jeremy@tregunna.ca".freeze
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze]
  s.homepage = "https://github.com/jeremytregunna/ruby-trello".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubyforge_project = "ruby-trello".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "A wrapper around the trello.com API.".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.2.0"])
      s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0.4.5"])
      s.add_runtime_dependency(%q<rest-client>.freeze, [">= 1.8.0"])
    else
      s.add_dependency(%q<activemodel>.freeze, [">= 3.2.0"])
      s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<oauth>.freeze, [">= 0.4.5"])
      s.add_dependency(%q<rest-client>.freeze, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<activemodel>.freeze, [">= 3.2.0"])
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<oauth>.freeze, [">= 0.4.5"])
    s.add_dependency(%q<rest-client>.freeze, [">= 1.8.0"])
  end
end
