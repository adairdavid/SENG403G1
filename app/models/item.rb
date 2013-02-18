class Item < ActiveRecord::Base
  has_many :physical_items, :dependent => :destroy

  belongs_to :author

  attr_accessible :title, :genre, :isbn13, :isbn10, :publisher, :year

  validates :title,  :presence => true
  validates :isbn13, :presence => true
  validates :isbn10, :presence => true
end
