class App < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::JSON

  namespace '/movies' do
    before do
      puts 'Params'
      p params
    end

    get do
      @movies = Movie.all
      json @movies
    end

    get '/:id' do |id|
      @movie = Movie.get(id)
      json @movie
    end

    put '/:id' do |id|
      @movie = Movie.get(id)
      @movie.update(params[:movie])
      json message: "Movie updated"
    end

    post do
      @movie = Movie.create(params[:movie])
      json message: "Movie created"
    end
  end
end
