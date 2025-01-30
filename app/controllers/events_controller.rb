class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]
  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to root_path, notice: "Event updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    puts "current_user: #{current_user.inspect}" # Debugging line
    @event = Event.find(params[:id])

    unless @event.invitees.include?(current_user) || @event.creator == current_user
      redirect_to root_path, alert: "you are not invited to this event"
    end
  end

  def destroy
    @event = current_user.events.find_by(id: params[:id])
    if @event
      @event.destroy
      redirect_to root_path, notice: "Event deleted successfully"
    else
      redirect_to root_path, alert: "Event not found or not authorized to delete."
    end
  end

  def invite
    @event = Event.find(params[:id])
    user = User.find_by(email: params[:email])
    puts "params[:email]: #{params[:email].inspect}"

    if user
      @event.event_invitees.create(user: user)
      redirect_to @event, notice: "User Invited Successfully"
    else
      redirect_to @event, alert: "User not found or already invited"
    end
  end

  private

  def event_params
    params.expect(event: [ :title, :date, :location ])
  end
end
