class Analysis < ApplicationRecord
  belongs_to :user
  has_many :criterion_importances, dependent: :destroy
  has_many :alternative_results,   dependent: :destroy
end
