class Product < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "200x200" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :title, uniqueness: true

	def self.latest
		Product.order(:updated_at).last
	end

end
