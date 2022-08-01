module ValidatesHcaptcha
  extend ActiveSupport::Concern

  def save_with_hcaptcha(response:, remote_ip:)
    if Hcaptcha.success?(response, remote_ip: remote_ip)
      save
    else
      valid?
      errors.add(:base, "Please complete the captcha")
      false
    end
  end
end
