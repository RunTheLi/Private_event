# app/controllers/attendances_controller.rb
class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @attendance = @event.attendances.build(attendee: current_user)
    if @attendance.save
      redirect_to event_path(@event), notice: "You've RSVPed to this event!"
    else
      redirect_to event_path(@event), alert: "Unable to RSVP."
    end
  end

  def destroy
    @attendance = @event.attendances.find(params[:id])
    @attendance.destroy
    redirect_to event_path(@event), notice: "You're no longer attending."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
