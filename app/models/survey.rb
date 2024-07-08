class Survey < ApplicationRecord
	validates :name, presence: true
	has_many :records
	accepts_nested_attributes_for :records, allow_destroy: true
end
