Easymon::Repository.add('database',
  Easymon::ActiveRecordCheck.new(ActiveRecord::Base)
)

Easymon::Repository.add('redis',
  Easymon::RedisCheck.new(
    YAML.load(
      ERB.new(
        File.read(Rails.root.join('config/cable.yml'))
      ).result
    )[Rails.env].symbolize_keys
  )
)

Easymon.authorize_with = ->(request) { request.headers['X-Forwarded-For'].nil? }
