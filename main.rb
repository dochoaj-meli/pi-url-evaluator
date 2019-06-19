# frozen_string_literal: true

require 'mechanize'
require_relative 'url_analyzer'

def portalinmobiliario_features
  %I[portalinmobiliario_home portalinmobiliario_search portalinmobiliario_vip]
end

def melilab_cookie
  cookie = Mechanize::Cookie.new('meliLab', 'portalinmobiliario')
  cookie.domain = '.portalinmobiliario.com'
  cookie.path = '/'
  cookie
end

def melilab_agent
  agent = Mechanize.new
  agent.user_agent_alias = 'Windows Chrome'
  agent.cookie_jar.add(melilab_cookie)
  agent
end

def portalinmobiliario_home_links
  url = 'https://www.portalinmobiliario.com/'
  melilab_agent.get(url).links
end

def portalinmobiliario_search_links
  url = 'https://www.portalinmobiliario.com/venta/departamento/nunoa-metropolitana'
  melilab_agent.get(url).links
end

def portalinmobiliario_vip_links
  url = 'https://www.portalinmobiliario.com/venta/departamento/nunoa-metropolitana/7168-eco-irarrazaval-nva'
  melilab_agent.get(url).links
end

def empty_map
  {
    NOT: [],
    ERR: [],
    EXC: []
  }
end

def evaluate_features
  result = {}

  portalinmobiliario_features.each do |pi_feature|
    puts "Evaluating #{pi_feature}..."
    result[pi_feature] = evaluate_urls send("#{pi_feature}_links".to_sym)
    puts ''
    report result[pi_feature], pi_feature
  end

  result
end

def report(result, feature)
  puts "Report for #{feature}:"

  result.each do |group, list|
    puts "- #{list.count} urls in #{group} state"
    puts '- Url detail is:' if list.count.positive?

    list.each do |url|
      puts "-- #{url} - #{UrlAnalyzer.run(url)}"
    end
  end

  puts ''
end

def evaluate_urls(links)
  puts "Found #{links.count} urls..."
  url_map = empty_map

  links.each do |link|
    melilab_agent.get(link.href)
    print '.'
  rescue Net::HTTPNotFound
    print 'x'
    url_map[:NOT].push link.href
  rescue Mechanize::ResponseCodeError
    print 'X'
    url_map[:ERR].push link.href
  rescue StandardError
    print '_'
    url_map[:EXC].push link.href
  end

  url_map
end

puts evaluate_features
# puts UrlAnalyzer.run('https://www.portalinmobiliario.com/arriendo/departamento/propiedades-usadas/sin-dormitorios/_PriceRange_0CLP-300000CLP_COVERED*AREA_*-55m%C2%B2')
