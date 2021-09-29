class TweetsController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_tweet, only: [:show,:edit,:destroy,:update]

    def index
        @tweets = Current.user.tweets
    end

    def new
        @tweet = Tweet.new 
    end

    def create
        
        @tweet = Current.user.tweets.create(tweet_params)
        Rails.logger.info(" Creando un twitt ")
        if @tweet.save
            
            redirect_to tweets_path, notice: "Tweet was scheduled succefully"
        else
            render :new    
        end
    end

    def edit
    end 

    def update
        if @tweet.update(tweet_params)
           
            redirect_to tweets_path, notice: "Tweet was updated succefully"
        else
            render :edit    
        end
    end
    
    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet was deleted succefully"
    end
   
    private

    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweets.find(params[:id])
    end
end