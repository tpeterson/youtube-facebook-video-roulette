require 'rubygems'
require 'net/http'
require 'json'
require 'oauth'

access_token = ""

page_id = "68680511262" #NFL's Facebook page

base_url = "https://graph.facebook.com"
token   = URI.encode_www_form("access_token" => access_token)
address = URI("#{base_url}/v2.2/#{page_id}/videos?#{token}")

videos = []
video_titles = []
video_embeds = []
video_ids = []
number_of_videos = 38 #number of videos since NFL-FB deal

while address != nil
  response = Net::HTTP.get(address)
  info = JSON.parse(response)

  info["data"].each do |x|
    video_id = x["id"]
    title = x["description"]
    embed_code = x["format"][1]["embed_html"]

    if videos.length < number_of_videos
      videos.push(
        id: video_id,
        title: title,
        embed: embed_code
      )
      video_titles.push(title)
      video_embeds.push(embed_code)
      video_ids.push(video_id)
    end
  end

  if info["paging"]["next"] && videos.length < number_of_videos
    address = URI(info["paging"]["next"])
  else
    puts "That's all"
    address = nil
  end
end

File.open("video_titles.txt", "w") do |f|
  f.puts JSON.pretty_generate(video_titles)
end

File.open("video_embeds.txt", "w") do |f|
  f.puts JSON.pretty_generate(video_embeds)
end

File.open("video_ids.txt", "w") do |f|
  f.puts JSON.pretty_generate(video_ids)
end
