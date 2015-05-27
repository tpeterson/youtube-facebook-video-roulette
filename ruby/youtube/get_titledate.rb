require 'rubygems'
require 'oauth'
require 'json'

video_IDs = Object.new

File.open("video_ids.txt") do |f|
  ids_file = f.read
  video_IDs = JSON.parse(ids_file)
end

DEVELOPER_KEY = ""

titles = []
dates = []

video_IDs.each do |video|
  baseurl = "https://www.googleapis.com/youtube/v3/"
  path    = "videos"
  query   = URI.encode_www_form(
              "part" => "snippet",
              "id" => video,
              "key" => DEVELOPER_KEY
              )
  address = URI("#{baseurl}#{path}?#{query}")
  response = Net::HTTP.get(address)

  video_info = JSON.parse(response)

  video_title = video_info["items"][0]["snippet"]["title"]
  titles.push(video_title)
  puts video_title

  video_timedate = video_info["items"][0]["snippet"]["publishedAt"]
  date_str = video_timedate.gsub(/T/, ",")
  date_array = date_str.split(/\,/)
  video_date = date_array[0]
  dates.push(video_date)
  puts video_date
end

File.open("video_titles.txt", "w") do |f|
  f.puts JSON.pretty_generate(titles)
end

File.open("video_dates.txt", "w") do |f|
  f.puts JSON.pretty_generate(dates)
end

puts "Video titles: #{titles.length}"
puts "Video dates: #{dates.length}"
