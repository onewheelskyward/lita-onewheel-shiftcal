require 'rest-client'
require_relative './models'

module Lita
  module Handlers
    class OnewheelShiftcal < Handler
      route /^shift$/i,
            :get_day_results,
            command: true
      route /^shift (\w+)$/i,
            :get_search_results,
            command: true

      def get_search_results(response)
        term = response.matches[0][0]
        Lita.logger.debug term
        res = RestClient.get("https://www.shift2bikes.org/api/search.php?q=#{term}")
        # Lita.logger.debug res.body
        json_data = JSON.parse(res.body, symbolize_names: true)
        events = EventResponse.new(json_data)
        events.events.each do |event|
          response.reply "#{event.title} #{event.date} #{event.time} #{event.shareable}"
        end
      end

      Lita.register_handler(self)
    end
  end
end
