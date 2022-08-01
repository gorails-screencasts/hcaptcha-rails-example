class Hcaptcha
  VERIFY_URI = "https://hcaptcha.com/siteverify"

  attr_reader :response, :remote_ip

  def self.sitekey
    ENV["HCAPTCHA_SITE_KEY"] || Rails.application.credentials.dig(:hcaptcha, :site_key)
  end

  def self.secret
    ENV["HCAPTCHA_SECRET"] || Rails.application.credentials.dig(:hcaptcha, :secret)
  end

  def self.verify(...)
    new(...).verify
  end

  def self.success?(...)
    new(...).success?
  end

  def initialize(response, remote_ip: nil)
    @response = response
    @remote_ip = remote_ip
  end

  def verify
    @body ||= JSON.parse(verify_request.body)
  end

  def success?
    verify["success"]
  end

  def verify_request
    Net::HTTP.post_form(URI(VERIFY_URI), {secret: self.class.secret, response: response, sitekey: self.class.sitekey, remoteip: remote_ip}.compact)
  end
end
