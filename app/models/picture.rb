class Picture < ApplicationRecord

	def picture_file= (p)
		if p
			self.data=p.read
			self.type=p.content_type
		end
	end
	self.inheritance_column = :_type_disabled # この行を追加
end
