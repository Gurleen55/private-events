class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])

    if @event.attendees.include?(current_user)
      redirect_to @event, alert: "you are already attending this event"
    else
      @event_attendee = EventAttendee.create(attended_event: @event, attendee: current_user)

      if @event_attendee.persisted?
        redirect_to @event, notice: "You have successfully attended the event"
      else
        redirect_to @event, notice: "something went wrong, try again"
      end
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event_attendee = EventAttendee.find_by(attended_event: @event, attendee: current_user)

    if @event_attendee
      @event_attendee.destroy
      redirect_to @event, notice: "you have successfully left the event"
    else
      redirect_to @event, alert: "you are not attending this event"
    end
  end
end
