class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json
  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
  end

  def lunchbot
    add_regex = /Lunchbot: add (.*)/i
    if params[:text] == "Lunch?"
      @restaurant = Restaurant.order('random()').first
      render json: {text: @restaurant.message_text}
    elsif matches = add_regex.match(params[:text])
      restaurant = Restaurant.create(name: matches[1])
      render json: {text: "Sure thing, boss. #{restaurant.name} added."}
    else
      render json: {text: "Sorry, didn't get that.\nYou can ask 'Lunch?' or 'Lunchbot: add <restaurant name>'"}
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/random
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :twitter)
    end

    def random_restaurant

      SlackIntegration.message_channel(@restaurant.message_text)
      render json: {body: 'ok'}, status: :ok
    end

    def message_channel(text, channel="#general")
      {channel: channel, text: text}
    end
end
