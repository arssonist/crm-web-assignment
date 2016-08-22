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

# Original post contacts
#
# post '/contacts' do
#   puts params
#     Contact.create(
#     params[:first_name],
#     params[:last_name],
#     params[:email],
#     params[:note]
#     )
#   redirect to('/contacts')
#
# the redirect is used to let us reconnect back to the page over and over.
# end

# post contacts with ActiveRecord
post '/contacts' do
  contact = Contact.create(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note],
  )
  redirect to('/contacts')
end
# putting variable infront of params makes it a getter/setter.

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

# to update
put '/contacts/:id' do

  @contact = Contact.find(params[:id].to_i)
  @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
    redirect to('/contacts')

  # if @contact
  #   @contact.first_name = params[:first_name]
  #   @contact.last_name = params[:last_name]
  #   @contact.email = params[:email]
  #   @contact.note = params[:note]

  #   redirect to('/contacts')
  # else
  #   raise Sinatra::NotFound
  # end
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

after do
  ActiveRecord::Base.connection.close
end
#this will close the database connection after use.
