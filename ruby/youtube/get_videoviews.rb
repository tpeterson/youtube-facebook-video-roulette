require 'rubygems'
require 'oauth'
require 'json'

video_IDs = Object.new

File.open("video_ids.txt") do |f|
  ids_file = f.read
  video_IDs = JSON.parse(ids_file)
end

DEVELOPER_KEY = ""

total_views = 0
video_views = []

video_IDs.each do |video|
  baseurl = "https://www.googleapis.com/youtube/v3/"
  path    = "videos"
  query   = URI.encode_www_form(
              "part" => "statistics",
              "id" => video,
              "key" => DEVELOPER_KEY
              )
  address = URI("#{baseurl}#{path}?#{query}")
  response = Net::HTTP.get(address)

  video_info = JSON.parse(response)
  views = video_info["items"][0]["statistics"]["viewCount"]
  total_views += views.to_i
  video_views.push(views.to_i)
  puts views.to_i
end

File.open("video_views.txt", "w") do |f|
  f.puts JSON.pretty_generate(video_views)
end

puts "Total views: #{total_views}"
puts "Average views per video: #{total_views} / #{video_IDs.length}"
puts "Videos: #{video_views.length}"
