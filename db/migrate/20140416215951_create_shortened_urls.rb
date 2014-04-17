class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|

      t.string :short_url
      t.text :long_url
      t.integer :submitter_id


      t.timestamp
    end

    add_index :shortened_urls, :submitter_id
    add_index :shortened_urls, :short_url, unique: true
  end
end
