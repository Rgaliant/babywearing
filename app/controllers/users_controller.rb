# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authorize_user
  after_action :assign_default_role, only: [:create]

  def index
    @users = User.order(params[:sort])
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def show    
  end

  def create
    @user = User.new(user_params)
    @user.add_role params[:role]
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
      @user.add_role params[:role]
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

  def assign_default_role
    set_user
    @user.add_role(:member) if @user.roles.count == 0
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :street_address, :street_address_second, :city, :state, :postal_code, :phone_number, :role)
  end
end
