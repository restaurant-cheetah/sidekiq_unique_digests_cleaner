# frozen_string_literal: true

require File.expand_path('../lib/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'sidekiq_unique_digests_cleaner'
  s.version     = VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.summary     = 'Tool for cleaning unique digests which were stuck because of SIGKILL or any other accident.'
  s.authors     = ["Max Honcharov"]
  s.email       = 'mxgoncharov@gmail.com'
  s.files       = ['lib/sidekiq_unique_digests_cleaner.rb']
  s.homepage    = 'https://rubygems.org/gems/sidekiq_unique_digests_cleaner'
  s.metadata    = { 'source_code_uri' => 'https://github.com/restaurant-cheetah/sidekiq_unique_digests_cleaner' }
  s.add_dependency 'sidekiq-unique-jobs', '>= 6.0 , < 8.0'
end
