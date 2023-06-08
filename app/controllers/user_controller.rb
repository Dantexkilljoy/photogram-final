class UserController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    the_username = params.fetch("path_id")

    matching_users = User.where({ :username => the_username })

    @the_user = matching_users.first

    render({ :template => "users/show.html.erb" })
  end
end
