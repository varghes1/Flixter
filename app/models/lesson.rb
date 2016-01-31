class Lesson < ActiveRecord::Base
	mount_uploader :video, VideoUploader
	belongs_to :section

	def next_lesson
		lesson = section.lesson.where("row_order > ?", self.row_order).rank(:row_order).first
		if lesson.blank? && section.next_section
			return section.next_section.lessons.rank(:row_order).first
		end
		
		return lesson

	end

	include RankedModel
	ranks :row_order, :with_same => :section_id
end
