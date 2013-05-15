class Url < ActiveRecord::Base
  
  belongs_to :user
  
  validates :url, :presence => true, :format => { :with => /^https?:\/\/[a-zA-Z0-9\-\.]+\.com|org|net|mil|edu|COM|ORG|NET|MIL|EDU$/}
  validates :code, :uniqueness => true
  before_save :rand_code  
  def rand_code
    self.code = ((1..9).to_a + ('a'..'z').to_a).sample(6).join('') unless self.code
  end

end

