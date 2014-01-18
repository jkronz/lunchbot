class Restaurant < ActiveRecord::Base
  def message_text
    if twitter.present?
      "How about #{name}? <https://twitter.com/#{twitter}>"
    else
      "How about #{name}?"
    end
  end
end
