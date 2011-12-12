class Reviews < ActiveRecord::Base
  attr_accessible :content
  
  validates :content, :presence => true, :length => {:maximum => 2000}
end