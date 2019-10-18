# frozen_string_literal: true

class UsersController < ApplicationController
  attr_reader :user
  def index
    @users = User.all
  end

  def show    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to user_index_path
  end

  private

  def user_params
    params.permit(:email, :full_name, :street_address, :street_addres_second, :city, :state, :postal_code, :phone_number)
  end
end
