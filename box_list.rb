# Simple script by ant0 to list all vulnhub box names.
# Thanks to taw for a refactor - https://github.com/taw/

require 'nokogiri'

home_page = Nokogiri::HTML(`curl -s "https://www.vulnhub.com/"`)
pages     = home_page.css(".pagination ul li a").map{|link| link[:href][/=(\d+)/,1]}.compact.map(&:to_i).max

puts "Getting box names for #{pages} pages:",""

box_list = (1..pages).map do |page|
  doc = Nokogiri::HTML(`curl -s "https://www.vulnhub.com/?page=#{page}"`)
  doc.css("h1 a").map(&:text)
end.flatten.sort_by(&:downcase)

puts box_list
