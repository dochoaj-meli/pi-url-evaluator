# frozen_string_literal: true

module Parser
  # Filter Parser
  class Filter
    def self.for(paths)
      return nil if paths.count.zero?

      last_path = paths.pop

      filters = paths.map do |path|
        path if whitelisted?(path)
      end

      filters.push(
        *parse_last(last_path)
      )

      filters.compact
    end

    def self.whitelisted?(path)
      whitelist.any? { |word| path.include?(word) }
    end

    def self.whitelist
      %w[dormitorio propiedades-usadas proyectos]
    end

    def self.parse_last(path)
      return unless path.start_with? '_'

      res = path.split('_')
      res.shift
      Hash[res.each_slice(2).to_a].keys
    end
  end
end
