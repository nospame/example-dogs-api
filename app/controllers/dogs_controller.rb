class DogsController < ApplicationController
  def create
    if current_user
      dog = Dog.new(
        name: params[:name],
        age: params[:age],
        breed: params[:breed],
        user_id: current_user.id
      )
      dog.save
      render json: {message: "Dog added."}
    else
      render json: {message: "User must be logged in to add dogs."}
    end
  end
end
