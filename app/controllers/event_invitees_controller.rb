class EventInviteesController < ApplicationController
  before_action :set_invite, only: %i[accept decline]

  def accept
    @invite.accepted!
    redirect_to invitations_path, notice: "Invitation accepted."
  end

  def decline
     @invite.declined!  # Uses enum method
    redirect_to invitations_path, notice: "Invitation declined."
  end

  private

  def set_invite
    @invite = current_user.event_invitees.find(params[:id])
  end
end
