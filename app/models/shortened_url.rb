class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  belongs_to :submitter, class_name: "User", foreign_key: :submitter_id, primary_key: :id
  has_many :visits, class_name: "Visit", foreign_key: :short_id
  has_many :visitors, -> { uniq }, through: :visits, source: :user

  def self.random_code
    code = SecureRandom.urlsafe_base64(16)
    return code if find_by(:short_url=>code).nil?
    self.random_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    sh_url = self.new( submitter_id: user.id, short_url: self.random_code,
    long_url: long_url)
    sh_url.save
    sh_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.pluck(:user_id).uniq.size
  end

  def num_recent_uniques(num_minutes)
    condition = ["created_at > ?", Time.now - num_minutes.minutes]
    visits.where(condition).pluck(:user_id).uniq.size
  end


  # def initialize(sub_id, short_url, long_url)
  #   @submitter_id, @short_url, @long_url = sub_id, short_url, long_url
  # end

end