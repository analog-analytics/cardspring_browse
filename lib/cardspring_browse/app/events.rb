require 'json'

module CardspringBrowse
  module App
    class Events < Controller

      get "/v1/events" do
        get_result = api.get(request_path)
        body = get_result.body
        body_hash = JSON.parse(body)
        events = body_hash['items']

        erb :events, :locals => {
          :events => events,
          :result_body => body,
          :current_url => url(body_hash['_uri']),
          :previous_url => url(body_hash['_previous_page_uri']),
          :next_url => url(body_hash['_next_page_uri'])
        }
      end

      get "/v1/events/:event_id" do
        result = api.get(request_path)
        body = result.body
        body_hash = JSON.parse(body)
        erb :event_details, :locals => {
          :result_body => body,
          :event_details => body_hash,
          :back_url => url("/v1/events")
        }
      end
    end
  end
end
