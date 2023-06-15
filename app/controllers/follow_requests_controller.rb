class FollowRequestsController < ApplicationController
  def create
    the_follow_request = FollowRequest.new
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.status = params.fetch("query_status")

    followed_user_id = params.fetch("query_recipient_id")
    followed_user = User.where(id: followed_user_id).first

    if the_follow_request.valid? && followed_user.private == false
      the_follow_request.save
      redirect_to("/users/#{followed_user.username}", { :notice => "Follow request created successfully." })
    elsif the_follow_request.valid? && followed_user.private == true
      the_follow_request.save
      redirect_to("/users", { :notice => "Follow request is pending." })
    else
      redirect_to("/users", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")
    the_follow_request.status = params.fetch("query_status")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/users/#{the_follow_request.recipient.username}", { :notice => "Follow request updated successfully." })
    else
      redirect_to("/users/#{the_follow_request.recipient.username}", { :alert => the_follow_request.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    followed_user = User.where(id: the_follow_request.recipient_id).first
    the_follow_request.destroy

    redirect_to("/users/#{followed_user.username}", { :notice => "Follow request deleted successfully." })
  end
end
