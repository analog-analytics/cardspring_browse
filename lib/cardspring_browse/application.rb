require 'sinatra/base'
require_relative 'app/publisher'
require_relative 'app/users'
require_relative 'app/events'
require_relative 'app/businesses'
require_relative 'app/apps'
require_relative 'app/transactions'
require_relative 'app/credit_cards'

module CardspringBrowse
  class Application < Sinatra::Base

    enable :method_override
    enable :config_file

    PROPERTY_NAME = 'cardspring_browse.config_file'
    use Rack::Config do |env|
      env[PROPERTY_NAME] = settings.config_file
    end

    use CardspringBrowse::App::Publisher
    use CardspringBrowse::App::Users
    use CardspringBrowse::App::Events
    use CardspringBrowse::App::Businesses
    use CardspringBrowse::App::Apps
    use CardspringBrowse::App::Transactions
    use CardspringBrowse::App::CreditCards

    def initialize(app, config_file = __FILE__)
      super(app)
      settings.config_file = config_file
    end

    get "/" do
      redirect to("/v1")
    end

  end
end
