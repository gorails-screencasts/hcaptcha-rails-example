require "addressable/uri"

module ActionTextNoFollowLinks
  def to_html
    fragment.replace("a") do |anchor|
      href = anchor.attributes["href"].value
      if allowed_domain?(href)
        anchor.remove_attribute("rel")
      else
        anchor["rel"] = "noopener nofollow"
      end
      anchor
    end.to_html
  end

  def allowed_domain?(url)
    ["gorails.com"].include? Addressable::URI.parse(url).domain
  end
end

ActiveSupport.on_load :action_text_content do
  self.prepend ActionTextNoFollowLinks
end

ActionText::ContentHelper.allowed_attributes += ["rel"]
