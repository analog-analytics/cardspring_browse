require 'json'

module CardspringBrowse
  module App
    class CreditCards < Controller

      get "/v1/credit_cards/new/:id" do
        get_result = api.get(request_path)
        erb :new_credit_card, :locals => {
          :post_url => url("/v1/users/#{params[:id]}/cards"),
          :back_url => url("/v1/users/#{params[:id]}")
        }
      end

      post "/v1/users/:id/cards" do
        result = api.post(request.path_info, {pan: params["credit_card"]["pan"], expiration: params["credit_card"]["expiration"]})
        body = result.body
        body_hash = JSON.parse(body)
         if body_hash['status'] && body_hash['status'].match(/^4/)
          p "Errors: ", body
        else
          redirect to("/v1/users/#{params[:id]}")
        end
      end

    end
  end
end
