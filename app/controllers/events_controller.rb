class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]
  def index
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])
  end
  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to event_path, notice: "Event created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(even.params)
      redirect_to @event, notice: "Event update successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to event_path, notice: "Event Deleted."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to @event, alert: "Not authorized." unless @event.creator == current_user
  end

  def event_params
    params.require(:event).permit(:name, :location, :date)
  end
end
