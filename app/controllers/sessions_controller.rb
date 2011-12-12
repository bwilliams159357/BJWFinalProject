class SessionsController < ApplicationController
  def new
    @title = "Sign In"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
                             
    if user.nil?
      #Create error message and re-render the signin
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign In"
      render 'new'
    else
      # Sign the user in and redirect to user's show page
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
