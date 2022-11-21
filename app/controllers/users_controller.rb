class UsersController < ApplicationController
  def new
    debugger
  end

  def show
    @user = User.find(params[:id])
  end
end
