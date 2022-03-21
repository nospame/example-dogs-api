class DogsController < ApplicationController
  def index
    if current_user
      dogs = Dog.where(user_id: current_user.id)
      render json: dogs.as_json
    else
      render json: {message: "User must be logged in to view dogs."}, status: :unauthorized
    end
  end

  def create
    if current_user
      dog = Dog.new(
        name: params[:name],
        age: params[:age],
        breed: params[:breed],
        user_id: current_user.id
      )
      dog.save
      render json: {message: "Dog created."}
    else
      render json: {message: "User must be logged in to create new dogs."}, status: :unauthorized
    end
  end

  def update
    dog = Dog.find_by(id: params[:id])
    if dog.user == current_user
      dog.name = params[:name] || dog.name
      dog.age = params[:age] || dog.age
      dog.breed = params[:breed] || dog.breed
      dog.save
      render json: {message: "Dog updated."}
    else
      render json: {message: "You cannot change a dog that is not yours."}, status: :unauthorized
    end
  end

  def destroy
    dog = Dog.find_by(id: params[:id])
    if dog.user == current_user
      dog.destroy
      render json: {message: "Dog deleted."}
    else
      render json: {message: "You cannot delete a dog that is not yours."}, status: :unauthorized
    end
  end
end
