class Api::V1::UsersController < ApplicationController

    def index 
        @users = User.all
        render json: @users 
    end

    def create
   
      @user = User.new(user_params)
      if @user.save
      render json: @user,status: :created
      else
        render json: {message: "Unable to create a user",errors:@user.errors.full_messages},status: :unprocessable_entity
      end
    end

    def show
        @user = User.find_by(id: params[:id])
        render json: @user
    end

    def edit
        @user = User.find_by(id: params[:id])
        render json: @user
    end

    def update
        @user = User.find_by(id: params[:id])
        if @user.present?
            @user.update(user_params)
            render json: {user:@user,message: "User updated successfully"},status: 201
        else
            render json: {message: "Unable to update a user",errors:@user.errors.full_messages},status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        if @user.present?
            @user.destroy
            render json: {message: "User deleted successfully"},status: 200
        else
            render error: {error: "Unable to updatedelete a user"},status: 404
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:username,:password)
    end


end
