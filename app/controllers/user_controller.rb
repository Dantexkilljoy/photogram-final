class UserController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb", alert: "You are not authorized for that. " })
  end

  def show
    the_username = params.fetch("path_id")

    matching_users = User.where({ :username => the_username })

    @the_user = matching_users.first

    @the_following = FollowRequest.where({ recipient_id: @the_user.id }).where({ sender_id: @current_user.id }).first

    if @the_user.private == false
      render({ :template => "users/show.html.erb" })
    elsif @the_following != nil && @the_following.status == "accepted"
      render({ :template => "users/show.html.erb" })
    else
      redirect_to("/", { notice: "You are not authorized for that." })
    end
  end
end
