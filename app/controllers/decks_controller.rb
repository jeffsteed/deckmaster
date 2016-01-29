class DecksController < ApplicationController
  def show
  end

  def new
    @deck = Deck.new
  end

  def create
    @user = current_user
    deck = params[:deck][:deck].split(',')
    @deck = Deck.new(name: params[:deck][:name], deck: deck, user_id: @user[:id])
    @deck.save
    redirect_to @user
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @user = current_user
    @deck = Deck.find_by(id: params[:id])
    new_deck = params[:deck][:deck].split(',')
    if @deck.update_attributes(deck: new_deck)
      flash[:success] = "Deck Saved Successfully"
      redirect_to @user
    else
      render "edit"
    end
  end
end
