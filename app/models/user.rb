class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :short_urls, class_name: "ShortenedUrl", foreign_key: :submitter_id

  has_many :visits, class_name: "Visit", foreign_key: :user_id
  has_many :visited_urls, -> { uniq }, through: :visits, source: :shortened_url
end