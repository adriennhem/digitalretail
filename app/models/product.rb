class Product < ActiveRecord::Base
	has_many :line_items
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "200x200" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :title, uniqueness: true

	def self.latest
		Product.order(:updated_at).last
	end

	before_destroy :ensure_not_referenced_by_any_line_item

	private

	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end

end
