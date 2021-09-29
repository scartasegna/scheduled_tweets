class RegistrationsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id]= @user.id
            redirect_to root_path, noitice:"Cuenta creada correctamente"
        else
            flash[:alert] = "Algo no esta bien"
            render :new     
        end
    end


    private 
    def user_params
        params.require(:user).permit(:email,:password,:password_confirmation)
    end

end
