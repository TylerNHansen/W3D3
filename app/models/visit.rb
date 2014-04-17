class Visit < ActiveRecord::Base
  belongs_to :shortened_url, class_name: "ShortenedUrl", foreign_key: :short_id
  belongs_to :user, class_name: "User", foreign_key: :user_id



  def self.record_visit!(user, shortened_url)
    saved_visit = self.new( user_id: user.id, short_id: shortened_url.id )
    saved_visit.save
    saved_visit
  end

end