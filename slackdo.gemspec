
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slackdo/version"

Gem::Specification.new do |spec|
  spec.name          = "slackdo"
  spec.version       = Slackdo::VERSION
  spec.authors       = ["segersniels"]
  spec.email         = ["segers.n@hotmail.com"]

  spec.summary       = %q{Send TODO tasks and reminders to yourself on Slack.}
  spec.description   = %q{SlackDO provides you with an easy CLI tool which allows you to write TODO tasks and reminders to yourself on Slack}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
