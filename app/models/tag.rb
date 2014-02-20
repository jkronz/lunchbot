class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :restaurants, through: :taggings

  validates :name,  presence: true, 
            uniqueness: { case_sensitive: false }

  before_save { self.name = name.downcase }

  def self.find_by_insensitive_name(name)
    Tag.where("lower(name) = ?", name.downcase).first
  end

#accessors

  def name
    self[:name].titleize
  end

end
