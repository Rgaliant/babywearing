# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authorize_user
  def index
    @users = User.order(params[:sort])
  end

  def show    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/users'
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to '/users'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to user_index_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :street_address, :street_address_second, :city, :state, :postal_code, :phone_number, :role)
  end
end
