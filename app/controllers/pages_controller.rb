class PagesController < ApplicationController
  def home
    @title = "Home"
  end
  
  def cpanel
    if current_user.nil?
      redirect_to root_path
    else
      @title = "#{current_user.email} - Control Panel - Profile"
    end
  end
  
  def gpage
    if params[:param2].nil?
      @title = "Game Page"
    else
      @rate = Float(params[:param2])
      if @rate < 1 || @rate > 10
        redirect_to gpage_path
      else
        @game = Game.find(Integer(params[:game]))
        @rating = Ratings.new(:user_id => current_user.id, :game_id => @game.id, :rating => @rate, :name => @game.name)
        @rating.save
        @totalrating = @game.total_ratings + @rate
        @numratings = @game.num_ratings + 1
        @newrating = @totalrating / @numratings
        @game.update_attributes(:total_ratings => @totalrating, :num_ratings => @numratings, :rating => @newrating)
        redirect_to gpage_path(:param1 => @game)
      end
    end
  end
  
  def gamesearch
    @title = "Search"
  end
  
  def friends
    if current_user.nil?
      redirect_to root_path
    else
      if !params[:param1].nil? || !params[:remove].nil?
        if !params[:param1].nil?
          @friend = User.find_by_email(params[:param1])
          if @friend.nil?
            redirect_to friends_path
          else
            @check = Friends.find_by_friend_id(@friend.id)
            if @check.nil?
              @new = Friends.new(:user_id => current_user.id, :friend_id => @friend.id) unless @friend.id == current_user.id
              @new.save unless @friend.id == current_user.id
            end
            redirect_to friends_path
          end
        else
          @rem = Friends.find(:all, :conditions => ['user_id LIKE ? AND friend_id LIKE ?', current_user.id, params[:remove]])
          @rem[0].destroy
          redirect_to friends_path
        end
      else
        @title = "#{current_user.email} - Control Panel - Friends List"
      end
    end
  end
  
  def collections
    if current_user.nil?
      redirect_to root_path
    else
      if params[:param1].nil? && params[:remove].nil?
        @title = "#{current_user.email} - Control Panel - Collections"
      else 
        if params[:remove].nil?
          @game = Game.find_by_id(params[:param1])
          @new = Collections.new(:user_id => current_user.id, :game_id => @game.id, :name => @game.name)
          @new.save
          redirect_to search_path(:q => params[:q])
        else
          @coll = Collections.find(:all, :conditions => ['user_id LIKE ? AND game_id LIKE ?', current_user.id, params[:remove]])
          if @coll.any?
            @coll.each do |coll|
              @game = coll
              @game.destroy
            end
          end
          redirect_to collections_path
        end
      end
    end
  end
end
