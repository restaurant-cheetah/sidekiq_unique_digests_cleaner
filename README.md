# SidekiqUniqueDigestsCleaner


__SidekiqUniqueDigestsCleaner__ is a simple tool for cleaning up stuck _Unique Digests_ in __Sidekiq__.
The most common example of such a situation occurs for Heroku users when the service restarts all instances once per day. As a result, it sends SIGTERM for shutdown and after 30 seconds, SIGKILL, so Sidekiq is unable to return all not-finished jobs to the queue. Due to this problem, job information is lost. However, the digests are still retained, but there is no way of adding a new job with the same worker and arguments.
### Installation

Install the gem as usual:
```sh
$ gem install sidekiq_unique_digests_cleaner
```
or just add this line to your `Gemfile`:
```
gem 'sidekiq_unique_digests_cleaner'
```

### Using

List of all stuck digests
```ruby
SidekiqUniqueDigestsCleaner.stuck_digests # returns the list of digests which are stuck
```
Clean them
```ruby
SidekiqUniqueDigestsCleaner.clean_unique_digests # remove all stuck digests
```

__For using it automatically on Sidekiq start add this line to your Sidekiq initializer__

```ruby
 Sidekiq.configure_server do |config|
    # Some code for your Sidekiq setup
    SidekiqUniqueDigestsCleaner.clean_unique_digests
  end
```

### Todos

 - Add tests

License
----
MIT
