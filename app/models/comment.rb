class Comment < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :message, required: true

  validates :content, presence: true, length: { minimum: 10}
end
