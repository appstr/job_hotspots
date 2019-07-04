class JobScrapersController < ApplicationController
  require 'open-uri'

  def index
    indeed_rails
    @jobs_hash = count_jobs
  end

  def indeed_rails
    if JobLocation.first.nil?
      counter = 0
      keep_running = true
      while keep_running
        url = "https://www.indeed.com/jobs?q=ruby+on+rails&sort=date&limit=50&fromage=15&radius=100&start=#{counter}"
        doc = open(url)
        html = Nokogiri::HTML(doc)
        duplicates = 0
        html.css('div .recJobLoc').each do |div|
          if !JobLocation.add_data(div.attributes['id'].value, div.attributes['data-rc-loc'].value)
            # Count duplicates in a row. Stop if 50 found in a row.
            duplicates += 1
            keep_running = false if duplicates >= 50
          end
        end
        counter += 50
      end
    end
  end

  def count_jobs
    hash = Hash.new(0)
    JobLocation.all.each do |job|
      state = job.location.split(", ")[1]
      hash[state] += 1
    end
    hash
  end

end
