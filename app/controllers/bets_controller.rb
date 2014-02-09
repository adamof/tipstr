class BetsController < ApplicationController
  def index
    if params[:tipster_id]
      @bets = Tipster.find(params[:tipster_id]).bets
    else
      @bets = Bet.all
    end

    respond_to do |format|
      format.json { render json: @bets }
    end
  end
end
