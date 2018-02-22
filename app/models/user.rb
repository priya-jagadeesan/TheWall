class User < ActiveRecord::Base
  has_secure_password
  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy

  PWD_Regex = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/
  validates :name, presence: true, length: { minimum: 5}, uniqueness: true
  validates_date :dateOfBirth, :on_or_before => lambda { Date.current }, :on_or_before_message => "cannot be a future date"
  validates :password, presence: true, format: { with: PWD_Regex, :multiline => true }, on: :create

  before_save :dateFormat

  private
  def dateFormat
    # self.dateOfBirth.strftime("%Y-%m-%d")
    self.dateOfBirth.to_date
  end
end
