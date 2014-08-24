class App < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::JSON

  post '/teste' do
    parametros = JSON.parse(request.env['rack.input'].read)
    #json movie
    movie = Movie.create(parametros["movie"])
    if movie
      halt 201, "filme criado with json"
    else
      halt 404, "erro"
    end
  end

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
      if params[:purchaseDate]
        puts "Purchase date foi passado"
      else
        puts "Purchase date NAO foi passado"
      end
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
