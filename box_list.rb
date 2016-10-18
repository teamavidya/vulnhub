require 'nokogiri'

home_page = Nokogiri::HTML(`curl -s "https://www.vulnhub.com/"`)
page_list = home_page.xpath('//div/div[contains(@class, "pagination")]/ul/li/a/@href').to_a.map(&:to_s)
pages     = page_list.reject{ |data| data.match(/=(\d+)/).nil? }.map{ |data| data.match(/=(\d+)/)[1].to_i }.max

box_list = []
puts "Getting box names for #{pages} pages:",""

(1..pages).each do |page|
  doc  = Nokogiri::HTML(`curl -s "https://www.vulnhub.com/?page=#{page}"`)
  box_list << doc.xpath('//h1/a/text()').to_a.map(&:to_s)
end

puts box_list.flatten.sort_by(&:downcase)
