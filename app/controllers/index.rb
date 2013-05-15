get '/' do
  erb :index
end

get '/login' do
  if session[:user_id] == nil
    erb :login
  else
    redirect to "/private/#{session[:user_id]}"
  end
end

get '/create' do
  session[:user_id] = nil
  erb :create
end

get '/private/:id' do
  if session[:user_id] == nil
    redirect to "/"
  elsif session[:user_id] != params[:id].to_i
    redirect to "/private/#{session[:user_id]}"
  else
    @user = User.find(session[:user_id])
    erb :private
  end
end

get '/private/' do
  redirect to '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end

post '/login' do
  params[:email]
  params[:password]
  if User.authenticate(params[:email], params[:password])
    @user = User.find_by_email(params[:email])
    session[:user_id] = @user.id
    redirect to "/private/#{@user.id}"
  else
    redirect to '/login'
  end
end

post '/create' do
  @user = User.create(:full_name => params[:full_name], 
                      :email => params[:email], :password => params[:password])
  session[:user_id] = @user.id
  redirect to "/private/#{@user.id}"
end

post '/shorten' do
  @new_shorty = Url.new(  :url => params[:url],
                          :user_id => session[:user_id] )
  if @new_shorty.save
    redirect to "/private/#{session[:user_id]}"
  else
    puts "Didn't save"
    puts @new_shorty.inspect
    erb :index
  end
end

get '/shorty/:code' do
  link = Url.find_by_code("#{params[:code]}") 
  link.increment(:clicks).save
  redirect link.url
end
