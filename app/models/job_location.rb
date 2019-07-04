class JobLocation < ApplicationRecord
  validates :job_id, uniqueness: true

  def self.add_data(job_id, location)
    j = JobLocation.new
    j.job_id = job_id
    j.location = location
    begin
      j.save!
      return true
    rescue
      puts "Unable to save data to database."
      return false
    end
  end

end
