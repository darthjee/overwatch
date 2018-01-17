
class AbilitiesController < ApplicationController
  include Common
  # GET /abilities
  # GET /abilities.json
  alias_method :index, :render_basic

  # GET /abilities/1
  # GET /abilities/1.json
  alias_method :show, :render_basic

  # GET /abilities/new
  def new
    render_basic
  end

  # GET /abilities/1/edit
  def edit
    render_basic
  end

  # POST /abilities
  # POST /abilities.json
  def create
    render json: created_ability.as_json
  end

  # PATCH/PUT /abilities/1
  # PATCH/PUT /abilities/1.json
  def update
    render json: updated_ability.as_json
  end

  # DELETE /abilities/1
  # DELETE /abilities/1.json
  def destroy
    ability.destroy
    head :no_content
  end

  private

  def new_json
    {}
  end

  def created_ability
    @created_ability ||= Ability.create(ability_params)
  end

  def updated_ability
    @updated_ability ||= ability.tap { |v| v.update(ability_params) }
  end

  def index_json
    Ability.all.as_json
  end

  def show_json
    ability.as_json
  end

  def ability
    @ability ||= Ability.find(ability_id)
  end

  def ability_id
    params.require(:id)
  end

  def ability_params
    params.require(:ability).permit(:name, :description, :is_ultimate)
  end

  alias_method :edit_json, :show_json
end
