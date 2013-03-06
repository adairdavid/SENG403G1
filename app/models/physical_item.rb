class PhysicalItem < ActiveRecord::Base

  # has_one :user through :rental 
  # In user model put has_many :physical_item through :rental


  attr_accessible :barcode_id
  validates :barcode_id, :uniqueness => true
  validates :barcode_id, :presence => true
  validates :barcode_id, :numericality => { :only_integer => true }
end
