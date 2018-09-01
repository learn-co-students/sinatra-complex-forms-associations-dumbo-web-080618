class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 

    @owner = nil
    @pet = Pet.create(name: params["pet_name"])
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find(params["pet"]["owner_ids"].first)
    end
    @pet.update(owner_id: @owner.id)
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'pets/show'
  end

  get '/pets/:id/edit' do 
    # binding.pry
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end

  # "Chewie Darling"
  # {"pet"=>{"name"=>"Chewie Darling", "owner_id"=>"1"}, "owner"=>{"name"=>""}, "captures"=>[], "id"=>"1"}
  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if (!params[:owner][:name].empty?)
      @pet.owner = Owner.create(name: params[:owner][:name])
    end
    # binding.pry
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end