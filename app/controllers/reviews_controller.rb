class ReviewsController < ApplicationController
  before_filter :authenticate
  
  def create
    @review = current_user.microposts.build(params[:review])
    if @review.save
      flash[:success] = "Review Created!"
      redirect_to cpanel_path
    else
      render root_path
    end
  end
  
  def destroy
  end
end
