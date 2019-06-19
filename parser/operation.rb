# frozen_string_literal: true

module Parser
  # Operation Parser
  class Operation
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
      %w[venta arriendo]
    end
  end
end
