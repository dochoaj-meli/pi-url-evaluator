require_relative 'parser/filter'
require_relative 'parser/location'
require_relative 'parser/operation'
require_relative 'parser/property_type'
# frozen_string_literal: true

# Obtains location, operation_type, property_type and filters for a PI URL
class UrlAnalyzer
  def self.run(url)
    return {} unless url
    return {} unless url.start_with? 'https://www.portalinmobiliario.com/'

    paths = parse_paths(url)

    {
      location: location(paths),
      operation_type: operation_type(paths),
      property_type: property_type(paths),
      filters: filters(paths)
    }
  end

  def self.parse_paths(url)
    url.gsub('https://www.portalinmobiliario.com/', '').split('/')
  end

  def self.location(paths)
    Parser::Location.for(paths)
  end

  def self.operation_type(paths)
    Parser::Operation.for(paths)
  end

  def self.property_type(paths)
    Parser::PropertyType.for(paths)
  end

  def self.filters(paths)
    Parser::Filter.for(paths)
  end
end
