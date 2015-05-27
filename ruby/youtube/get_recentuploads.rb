require 'rubygems'
require 'oauth'
require 'json'

ids_file = "video_ids.txt"

DEVELOPER_KEY = ""

recent_uploads = "UUDVYQ4Zhbm3S2dlz7P1GBDg" #for NFL channel

baseurl = "https://www.googleapis.com/youtube/v3/"
path    = "playlistItems"

query   = URI.encode_www_form(
            "part" => "snippet",
            "playlistId" => recent_uploads,
            "key" => DEVELOPER_KEY,
            "maxResults" => 50
            )

address = URI("#{baseurl}#{path}?#{query}")

video_IDs = []
video_titles = []

while address != nil
  response = Net::HTTP.get(address)
  info = JSON.parse(response)

  info["items"].each do |item|
    video_id = item["snippet"]["resourceId"]["videoId"]
    video_IDs.push(video_id)

    video_title = item["snippet"]["title"]
    video_titles.push(video_title)
  end

  puts "Grabbed #{video_IDs.length} videos so far"

  # Re-run request if more pages available by adding pageToken param
  if info["nextPageToken"]
    page_token = info["nextPageToken"]

    query   = URI.encode_www_form(
                "part" => "snippet",
                "playlistId" => recent_uploads,
                "key" => DEVELOPER_KEY,
                "maxResults" => 50,
                "pageToken" => page_token
                )

    address = URI("#{baseurl}#{path}?#{query}")
    puts "Next!"
  else
    address = nil
    puts "No next!"
  end
end

File.open(ids_file, "w") do |f|
  f.puts JSON.pretty_generate(video_IDs)
end

puts "Videos grabbed: #{video_IDs.length}"
puts "Most recent video title: #{video_titles[0]}"
puts "Last video title: #{video_titles[video_titles.length.to_i - 1]}"
