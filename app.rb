require 'sinatra'
require 'json'

  get '/' do  #root 
    File.read('views/index.html')
  end

  get '/favorites' do # GET request to read /favorites
    response.header['Content-Type'] = 'application/json'
    File.read('data.json') #reading from data.json
  end

  post '/favorites' do # POST request to write favorites to /favorites
    file = JSON.parse(File.read('data.json'))
    unless params[:title] && params[:year]
      return 'Invalid Request'
    end
    movie = { title: params[:title], year: params[:year] } #setting attributes from POST request into movies object
    file << movie #pushing movie object to our file
    File.write('data.json',JSON.pretty_generate(file))
    movie.to_json 
end
