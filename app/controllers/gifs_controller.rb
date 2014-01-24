require 'nokogiri'
require 'open-uri'
class GifsController < ApplicationController
	def reaction
		url_pattern = /http:\/\/replygif\.net\/thumbnail\/(\d+).gif/i
		doc = Nokogiri::HTML(open("http://replygif.net/t/#{params[:search]}"))
		gifs = doc.css('.gif')		
		if gifs.present?
			gif = gifs[Random.rand(gifs.count)]
			gif_id = url_pattern.match(gif.attributes['src'].value)[1]
			url = "https://scoutmob.slack.com/services/hooks/incoming-webhook?token=#{SlackConfig.first.token}"
			response = Typhoeus.post(url, body: {"channel" => "##{params[:channel_name]}", "username" => params[:username], "text" => "http://replygif.net/i/#{gif_id}.gif"}.to_json) 			
			render text: ""
		else 
			render text: "no gifs found :("
		end
	end
end
