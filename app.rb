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
      if @movie
        json @movie
      else
        halt 404, 'Movie not found'
      end
    end

    put '/:id' do |id|
      begin
        @movie = Movie.get(id)
        @movie.update(params[:movie])
        halt 204
      rescue
        halt 404, 'Movie not updated'
      end
    end
      
    post do
      @movie = Movie.create(params[:movie])
      if @movie
        halt 201, "Movie created"
      else
        halt 404, "Movie not created"
      end
    end

    delete '/:id' do |id|
      begin
        @movie = Movie.get(id)
        @movie.destroy
        halt 204
      rescue 
        halt 404, 'Movie not removed'
      end
    end
  end
end
