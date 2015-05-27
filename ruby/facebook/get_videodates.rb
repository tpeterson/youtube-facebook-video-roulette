require 'rubygems'
require 'net/http'
require 'json'
require 'oauth'

access_token = ""

page_id = "68680511262" #NFL Facebook page

base_url = "https://graph.facebook.com"
token   = URI.encode_www_form("access_token" => access_token)
address = URI("#{base_url}/v2.2/#{page_id}/videos?#{token}")

videos = []
video_dates = []
number_of_videos = 38

while address != nil
  response = Net::HTTP.get(address)
  info = JSON.parse(response)

  info["data"].each do |x|
    video_id = x["id"]
    #image = x["format"][1]["picture"]
    image_mobile = x["format"][0]["picture"]
    video_timedate = x["created_time"]

    if videos.length < number_of_videos
      videos.push(
        id: video_id,
        date: video_timedate
      )

      date_str = video_timedate.gsub(/T/, ",")
      date_array = date_str.split(/\,/)
      video_date = date_array[0]

      video_dates.push(video_date)
    end
  end

  if info["paging"]["next"] && videos.length < number_of_videos
    address = URI(info["paging"]["next"])
  else
    puts "That's all"
    address = nil
  end
end

File.open("video_dates.txt", "w") do |f|
  f.puts JSON.pretty_generate(video_dates)
end
