class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :restaurant

  validates_uniqueness_of :tag_id, scope: :restaurant_id
end
