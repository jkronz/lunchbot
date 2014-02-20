class Restaurant < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :name,  presence: true,
            uniqueness: { case_sensitive: false }

  def self.tagged_with(tagname)
    Tag.find_by_insensitive_name(tagname).restaurants
  end

  def tag!(tagname)
    @current_tag = Tag.find_by_insensitive_name(tagname)
    if @current_tag.present?
      self.taggings.create(tag_id: @current_tag.id)
    else
      self.tags.create!(name: tagname)
    end

  end

    def message_text
      if twitter.present?
        "How about #{name}? <https://twitter.com/#{twitter}>"
      else
        "How about #{name}?"
    end
  end
end
