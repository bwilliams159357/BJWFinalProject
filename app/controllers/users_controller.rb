class UsersController < ApplicationController  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @title = "User List"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if !current_user.nil? && @user.email == current_user.email
      @title = "#{current_user.email} - Control Panel"
      redirect_to "/controlpanel"
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @user }
    #end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @title = "User Registration";

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    redirect_to root_path
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to "/controlpanel"
    else
      @title = "Signup"
      render 'new'
    end
  end
#    respond_to do |format|
 #     if @user.save
  #      format.html { redirect_to @user, notice: 'User was successfully created.' }
   #     format.json { render json: @user, status: :created, location: @user }
    #  else
     #   format.html { render action: "new" }
      #  format.json { render json: @user.errors, status: :unprocessable_entity }
       #end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
