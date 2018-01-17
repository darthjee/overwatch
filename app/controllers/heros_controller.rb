class HerosController < ApplicationController
  include Common
  # GET /heros
  # GET /heros.json
  alias_method :index, :render_basic

  # GET /heros/1
  # GET /heros/1.json
  alias_method :show, :render_basic

  # GET /heros/new
  def new
    render_basic
  end

  # GET /heros/1/edit
  def edit
    render_basic
  end

  # POST /heros
  # POST /heros.json
  def create
    render json: created_hero.as_json
  end

  # PATCH/PUT /heros/1
  # PATCH/PUT /heros/1.json
  def update
    render json: updated_hero.as_json
  end

  # DELETE /heros/1
  # DELETE /heros/1.json
  def destroy
    hero.destroy
    head :no_content
  end

  private

  def new_json
    {}
  end

  def created_hero
    @created_hero ||= Hero.create(hero_params)
  end

  def updated_hero
    @updated_hero ||= hero.tap { |v| v.update(hero_params) }
  end

  def index_json
    Hero.all.as_json
  end

  def show_json
    hero.as_json
  end

  def hero
    @hero ||= Hero.find(hero_id)
  end

  def hero_id
    params.require(:id)
  end

  def hero_params
    params.require(:hero).permit(:name, :real_name, :health, :armor, :shield)
  end

  alias_method :edit_json, :show_json
end
