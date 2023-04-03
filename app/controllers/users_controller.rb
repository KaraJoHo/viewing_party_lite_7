class UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])
    @movie_details = @user.movie_ids.map do |movie_id|
      facade = UserFacade.new(nil, nil)
      facade.get_movie_details(movie_id)
      facade.details
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user[:email] = user[:email].downcase
    if user.save
      redirect_to user_path(user)
    else
      # flash[:error] = "Error: Invalid form entry"
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to "/register"
    end
  end

  def login_form 
    
  end

  def login 
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      redirect_to user_path(user)
    else 
      flash[:error] = "Sorry, your credentials are bad"
      render :login_form
    end
  end











  def discover
    @user = User.find(params[:id])
  end

  def movie_results 
    search = params[:search]
    top_rated_search = params[:top_rated_search]
    
    @user = User.find(params[:id])

    facade = UserFacade.new(search, top_rated_search)
    @movie_results = facade.determine_search
  end
  
  def movie_details 
    facade = UserFacade.new(nil, nil)
    facade.get_movie_details(params[:movie_id])

    @details = facade.details 
    @reviews = facade.reviews
    @credits = facade.credits
    @user = User.find(params[:user_id])
  end

  private
    # def user_params
    #   params.permit(:name, :email)
    # end
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end