# frozen_string_literal: true

module Parser
  # Location Parser
  class Location
    def self.for(paths)
      return nil if paths.count.zero?

      parse(paths)
    end

    def self.parse(paths)
      result = nil

      paths.each do |path|
        result = path unless blacklisted?(path)
      end

      result
    end

    def self.blacklisted?(path)
      path.start_with?(*blacklist)
    end

    def self.blacklist
      %w[
        oficina departamento casa comercial bodega industrial estacionamiento
        sitio parcela agricola terreno propiedad proyecto
        dormitorio venta arriendo _
      ]
    end
  end
end
