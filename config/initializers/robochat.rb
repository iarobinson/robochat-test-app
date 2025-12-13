Robochat.configure do |config|
  # Which providers to enable
  config.providers = [:claude]
  config.default_provider = :claude
  
  # Claude configuration (change api_key to claude_api_key)
  config.claude_api_key = ENV['ANTHROPIC_API_KEY'] || Rails.application.credentials.dig(:anthropic, :api_key)
  config.claude_model = 'claude-sonnet-4-20250514'
  config.claude_max_tokens = 4000
  
  # Shared settings
  config.temperature = 1.0
  config.system_prompt = "Robochat + AI assistant = ❤️"
end
