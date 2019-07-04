class CreateJobLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :job_locations do |t|
      t.string :job_id, unique: true
      t.string :location
      t.timestamps
    end
  end
end
