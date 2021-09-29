class OmniauthCallbacksController < ApplicationController

    def twitter
        if Current.user.present?
            
            twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
            twitter_account.update(
                name: auth.info.name,
                username:auth.info.nickname ,
                image: auth.info.image,
                token: auth.credentials.token,
                secret: auth.credentials.secret,
            )

            redirect_to twitter_accounts_path, notice: "Succefully conected @#{twitter_account.username}!!"
        else
            redirect_to root_path, alert: "Need to be logged in to add the account"
        end
    end

    def auth
        request.env['omniauth.auth']
    end
end