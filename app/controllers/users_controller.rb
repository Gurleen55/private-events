class UsersController < ApplicationController
  def show
  end

  def invitation
    @invitations = current_user.event_invitees.pending
  end
end
