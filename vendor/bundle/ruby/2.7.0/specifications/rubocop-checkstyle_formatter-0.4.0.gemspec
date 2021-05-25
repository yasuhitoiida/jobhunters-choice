# -*- encoding: utf-8 -*-
# stub: rubocop-checkstyle_formatter 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rubocop-checkstyle_formatter".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eito Katagiri".freeze]
  s.date = "2017-04-23"
  s.description = "A formatter for rubocop that outputs in checkstyle format".freeze
  s.email = ["eitoball@gmail.com".freeze]
  s.homepage = "https://github.com/eitoball/rubocop-checkstyle_formatter".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A formatter for rubocop that outputs in checkstyle format".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rubocop>.freeze, [">= 0.35.1"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 1.0.0"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.1"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  else
    s.add_dependency(%q<rubocop>.freeze, [">= 0.35.1"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 1.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  end
end
