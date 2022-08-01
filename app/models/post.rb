class Post < ApplicationRecord
  include ValidatesHcaptcha

  has_rich_text :body
end
