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
    @event = Event.find(params[:id])
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

  private

  def event_params
    params.expect(event: [ :title, :date, :location ])
  end
end
