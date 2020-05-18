# SidekiqUniqueDigestsCleaner


__SidekiqUniqueDigestsCleaner__ is a simple tool for cleaning up stuck _Unique Digests_ in __Sidekiq__.
The most common example of such situiation ia actual for __Heroku__ users when service restarts all the instances once per day. It sends _SIGTERM_ for shutting down dyno and after 30 second it sends _SIGKILL_ after what __Sidekiq__ is unable to return all not-finished jobs to the queue. In this situation information about jobs is lost, but unique digests are still persist and there is no ability for adding new job with the same worker and arguments.

### Installation

For using this gem your app should have `sidekiq_unique_jobs ~> 6.0` on a board.

Install the gem as usual:
```sh
$ gem install sidekiq_unique_digests_cleaner
```
or just add this line to your `Gemfile`:
```
gem 'sidekiq_unique_digests_cleaner'
```

### Using

For now, you can get the list of all stuck digests or delete them

```ruby
SidekiqUniqueDigestsCleaner.stuck_digests # returns the list of digests which are stuck
```

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
 - Add support for `sidekiq_unique_jobs` versions `7.x` and `<6.x`

License
----
MIT
