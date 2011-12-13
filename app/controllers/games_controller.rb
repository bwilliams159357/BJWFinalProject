class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    if !current_user.nil? && current_user.admin
      @games = Game.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @games }
      end
    else
      redirect_to root_path
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if !current_user.nil? && current_user.admin
      @game = Game.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @game }
      end
    else
      redirect_to root_path
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    if !current_user.nil? && current_user.admin
      @game = Game.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @game }
      end
    else
      redirect_to root_path
    end
  end

  # GET /games/1/edit
  def edit
    if !current_user.nil? && current_user.admin
      @game = Game.find(params[:id])
    else
      redirect_to root_path
    end
  end

  # POST /games
  # POST /games.json
  def create
    if !current_user.nil? && current_user.admin
      @game = Game.new(params[:game])

      respond_to do |format|
        if @game.save
          format.html { redirect_to @game, notice: 'Game was successfully created.' }
          format.json { render json: @game, status: :created, location: @game }
        else
          format.html { render action: "new" }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end      
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    if !current_user.nil? && current_user.admin
      @game = Game.find(params[:id])

      respond_to do |format|
        if @game.update_attributes(params[:game])
          format.html { redirect_to @game, notice: 'Game was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    if !current_user.nil? && current_user.admin
      @game = Game.find(params[:id])
      @collections = Collections.find(:all, :conditions => {:game_id => @game.id})
      if @collections.any?
        @collections.each do |coll|
          coll.destroy
        end
      end
      @game.destroy
      respond_to do |format|
        format.html { redirect_to games_url }
        format.json { head :ok }
      end
    else
      redirect_to root_path
    end
  end
end