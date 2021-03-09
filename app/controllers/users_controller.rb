class UsersController < ApplicationController
    skip_before_action :verified_user, only: [:new, :create]

    def new
        @user = User.new
        render 'users/new'
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def create
        @user = User.create(user_params)
        if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          render 'new'
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin)
        end

end
