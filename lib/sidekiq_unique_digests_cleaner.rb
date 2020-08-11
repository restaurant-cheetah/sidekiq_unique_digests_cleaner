# frozen_string_literal: true

class SidekiqUniqueDigestsCleaner
  def self.clean_unique_digests
    Sidekiq.logger.info('######## Starting cleaning up locked unique digests...')
    digests = stuck_digests
    if digests.any?
      Sidekiq.logger.info('######## Looks like those digests are stuck: ' + digests.join(', '))
      Sidekiq.logger.info('######## Unlocking digests...')
      digests.map { |digest| SidekiqUniqueJobs::Digests.del(digest: digest) }
      Sidekiq.logger.info('######## Unlocked!')
    else
      Sidekiq.logger.info('######## What is the nice day! Nothing to unlock.')
    end
  end

  def self.stuck_digests
    digests_with_lock = [
      Sidekiq::ScheduledSet.new.map(&:value),
      Sidekiq::RetrySet.new.map(&:value),
      Sidekiq::Queue.all.map { |queue| queue.map(&:value) },
    ].flatten.map { |job_value| JSON.parse(job_value, symbolize_names: true)[:unique_digest] }

    digests_with_lock += Sidekiq::Workers.new.map { |_pid, _tid, job| job['unique_digest'] }

    SidekiqUniqueJobs::Digests.all - digests_with_lock
  end
end
