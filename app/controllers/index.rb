get '/' do
  erb :index
end

get '/login' do
  if session[:user_id] == nil
    erb :login
  else
    redirect to "/secret/#{session[:user_id]}"
  end
end

get '/create' do
  session[:user_id] = nil
  erb :create
end

get '/secret/:id' do
  if session[:user_id] == nil
    redirect to "/"
  elsif session[:user_id] != params[:id].to_i
    redirect to "/secret/#{session[:user_id]}"
  else
    @user = User.find(session[:user_id])
    erb :secret
  end
end

get '/secret/' do
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
    redirect to "/secret/#{@user.id}"
  else
    redirect to '/login'
  end
end

post '/create' do
  @user = User.create(:full_name => params[:full_name], 
                      :email => params[:email], :password => params[:password])
  session[:user_id] = @user.id
  redirect to "/secret/#{@user.id}"
end
