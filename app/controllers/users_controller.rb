class UsersController < ApplicationController
    before_action :is_admin, only: [:index, :destroy]
    
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    # Sign-up page for Onli-Do
    def new
        @user = User.new
    end

    # Create a new user
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    # Only self is able to update
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Account details updated successfully"
            redirect_to @user
        else
            render "edit", status: :unprocessable_entity
        end
    end

    # Deletes a user
    # Only an admin or self is able to delete
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_url, status: :see_other
    end

    private

        def is_admin
            # Find a user by their session
            # Validate admin
            # Redirect to show if not admin
        end

        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
