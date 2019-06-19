# frozen_string_literal: true

module Parser
  # PropertyType Parser
  class PropertyType
    def self.for(paths)
      return nil if paths.count.zero?

      parse(paths)
    end

    def self.parse(paths)
      result = nil

      paths.each do |path|
        result = path if whitelisted?(path)
      end

      result
    end

    def self.whitelisted?(path)
      path.start_with?(*whitelist)
    end

    def self.whitelist
      %w[
        agricola bodega casa departamento estacionamiento
        industrial comercial oficina parcela sitio terreno
      ]
    end
  end
end
