class TipstersController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Tipster.all }
    end
  end
end
