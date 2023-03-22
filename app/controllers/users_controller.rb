class UsersController <ApplicationController
  def show 
    @user = User.find(params[:id])
  end

  def new

  end

  def create
    user = User.create!(user_params)
    redirect_to user_path(user)
  end

  def discover
    @user = User.find(params[:id])

    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = ENV["TMDB_API_KEY"]
    end
    response = conn.get("/3/movie/top_rated?")
    
    data = JSON.parse(response.body, symbolize_names: true)

    top_20 = data[:results][0..19]

    @top_20_names = top_20.map {|movie| movie[:original_title]}
  end

  private
  def user_params
    params.permit(:name, :email)
  end
end