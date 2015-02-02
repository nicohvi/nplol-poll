require 'will_paginate/array'
class UsersController < ApplicationController
  before_action :require_login, only: [:show, :votes, :polls]
  before_action :new_user, only: [:new, :login_form, :register_form] 

  def new
  end

  def login
    @user = User.find_by(email: user_params[:email]) 
    if @user && @user.authenticate(user_params[:password])
      sign_in_and_redirect
    else
      if @user.nil?
        flash.now[:error] = t('user.errors.wrong_email')
      else
        flash.now[:error] = t('user.errors.wrong_password')
      end
      @user = User.new(user_params)
      render 'new'
    end
  end

  def login_form
    render partial: 'login_form'
  end

  def register_form
    render partial: 'register_form' 
  end  

  def create
    @user = User.new(user_params)
    @user.save ? sign_in_and_redirect : render('new')
  end
 
  def show
    set_polls
  end

  def polls
    set_polls
  end

  def votes
    set_votes
  end

  private
  
  def new_user
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def sign_in_and_redirect
    sign_in(@user)
    redirect_to(@user)
  end

  def set_polls
    @polls = current_user.created_polls.paginate(page: params[:page], per_page: 5)
  end

  def set_votes
    @votes = @current_user.polls.paginate(page: params[:page], per_page: 5)
  end

end
