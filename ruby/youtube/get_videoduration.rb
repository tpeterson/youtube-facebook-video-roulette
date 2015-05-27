require 'rubygems'
require 'oauth'
require 'json'

video_IDs = Object.new

File.open("video_ids.txt") do |f|
  ids_file = f.read
  video_IDs = JSON.parse(ids_file)
end

DEVELOPER_KEY = ""

total_duration = 0
videos_duration = []

video_IDs.each do |video|
  baseurl = "https://www.googleapis.com/youtube/v3/"
  path    = "videos"
  query   = URI.encode_www_form(
              "part" => "contentDetails",
              "id" => video,
              "key" => DEVELOPER_KEY
              )
  address = URI("#{baseurl}#{path}?#{query}")
  response = Net::HTTP.get(address)

  video_info = JSON.parse(response)
  duration = video_info["items"][0]["contentDetails"]["duration"]

  duration_str = duration.gsub(/PT/, "")
  duration_minutes = Object.new
  duration_seconds = Object.new

  if duration_str.match(/M/)
    remove_m = duration_str.gsub(/M/,",")
    remove_s = remove_m.gsub(/S/, "")

    duration_array = remove_s.split(/\,/)
    duration_minutes = duration_array[0].to_i * 60

    duration_seconds = duration_minutes + duration_array[1].to_i
    puts "Video is #{duration_seconds} seconds long"
  else
    duration_seconds = duration_str.gsub(/S/, "")
    puts "Video is #{duration_seconds} seconds long"
  end

  videos_duration.push(duration_seconds.to_i)

  total_duration += duration_seconds.to_i
  puts total_duration
end

File.open("video_lengths.txt", "w") do |f|
  f.puts JSON.pretty_generate(videos_duration)
end

average_duration = total_duration.to_i / video_IDs.length.to_i

puts "Total duration: #{total_duration} seconds"
puts "Average duration: #{average_duration} seconds"
