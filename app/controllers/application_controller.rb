class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_basic
    action = params[:action]
    respond_to do |format|
      format.json { render json: send("#{action}_json") }
      format.html { render action }
    end
  end

  def not_found
    head :not_found
  end
end
