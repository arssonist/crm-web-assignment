# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require 'sinatra'
require_relative 'contact'
#


# puts the app name and time
get '/' do
  @crm_app_name = "the CRM web app"
  @time = Time.new
  erb :index
end

# gets all contacts
get '/contacts' do
  erb :contacts
end

# gets create new contact
get '/contacts/new' do
  erb :new_contact
end


post '/contacts' do
  puts params
    Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
# the redirect is used to let us reconnect back to the page over and over.
end

#supposed to set gernerlization
get '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end
#non-working code for gernalize finding a contact
get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id].to_i)
    if @contact
      erb :edit_contact
    else
      raise Sinatra::NotFound
    end
end

# non working code for editing a contact
put '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

#
# non-working code for deleting contact
delete '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end
