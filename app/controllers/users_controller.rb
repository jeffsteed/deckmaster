class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

#######  RESTful architecture #######

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @decks = Deck.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # successful registration
      log_in(@user)
      flash[:success] = "Welcome to Decksmith!"
      redirect_to @user
    else
      # unsuccessful registration
      render "new"
    end
  end

  def edit
    # @user = User.find(params[:id]) is no longer needed due to the current_user
    # method and before_action call.
  end

  def update
    # @user = User.find(params[:id]) no longer needed, see 'edit'
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    # confirms a logged in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
