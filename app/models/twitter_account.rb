class TwitterAccount < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :user 
  

  validates :username, uniqueness: true
  #
  #Creates a client getting the keys for the api from the config files and client stuff from db
  #
  def client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret     = Rails.application.credentials.dig(:twitter, :api_secret)
      config.access_token        = token
      config.access_token_secret = secret
    end
  end 
end
