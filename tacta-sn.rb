require 'sinatra'
require './contacts_file'

set :port, 4567

get '/' do
   "<h1>Tacta Contact Manager</h1>"
end

get '/contacts' do
   @contacts = read_contacts
   erb :'contacts/index'
end

get '/contacts/new' do
   erb :'contacts/new'
end

post '/contacts' do
   new_contact = { name: params[:name], phone: params[:phone], email: params[:email] }

   contacts = read_contacts
   contacts << new_contact
   write_contacts( contacts )

   i = contacts.length - 1

   redirect "/contacts/#{i}"
end

get '/contacts/:i' do
   @i = params[:i].to_i
   contacts = read_contacts
   @contact = contacts[@i]
   erb :'contacts/show'
end

get '/contacts/:i/edit' do
   @i = params[:i].to_i

   contacts = read_contacts
   @contact = contacts[@i]

   erb :'contacts/edit'
end

post '/contacts/:i/update' do
   i = params[:i].to_i

   updated_contact = { name: params[:name], phone: params[:phone], email: params[:email] }

   contacts = read_contacts
   contacts[i] = updated_contact
   write_contacts( contacts )

   redirect "/contacts/#{i}"
end

get '/contacts/:i/delete' do
   i = params[:i].to_i

   contacts = read_contacts
   contacts.delete_at( i )
   write_contacts( contacts )

   redirect "/contacts"
end

get './contacts/search' do
  @contacts = search_contacts
end








# op pagina contacts a search function
# - link   # add a link from the show page to search
# - plek om je zoekopdracht in te vullen # search form??
# - code om te laten zoeken   # make a route to search a contact
# - resultaat weergeven   #show result

# 2 dingen:
# een search method in controller file
# search.erb (hier gaat zelfde code in als new)
# results.erb

#made a link in the show.erb
# -----add a route ----
#create edit contact form in search.erb (copy code from new.erb)

#next try:
#copied bootstrap code in index file for search button.
# next, create a search function so it can actually search
