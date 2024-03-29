require 'sidekiq'
require 'sidekiq/web'

rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
redis_config = YAML.load_file(rails_root.to_s + '/config/redis.yml')
redis_config.merge! redis_config.fetch(Rails.env, {})
redis_config.symbolize_keys!

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ['root', 'root']
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/0" }
end
