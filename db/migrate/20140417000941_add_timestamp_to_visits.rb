class AddTimestampToVisits < ActiveRecord::Migration
  def change
    change_table(:visits) do |t|
      t.timestamps
    end
  end
end
