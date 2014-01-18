class SlackIntegration
  def self.url
    config = SlackConfig.first
    "https://scoutmob.slack.com/services/hooks/incoming-webhook?token=#{config.token}"
  end

  def self.message_channel(text)
    body = {text: text}
    Rails.logger.debug "body.to_json #{body.to_json}"
    response = Typhoeus.post(url, body: body.to_json)
    Rails.logger.debug "response: #{response.inspect}"
  end
end