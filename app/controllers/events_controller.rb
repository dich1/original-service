class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.all
  end
  
  def new
    if logged_in?
      @events = Event.new
    else
      flash[:warning] = "ログインしてください"
      redirect_to login_path
    end
  end
  
  def create
      @event = Event.new(event_params)
      @event.save
      flash[:success] = "イベントを保存しました"
      redirect_to events_path
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def join
    
  end
  
  def attend
    if logged_in?
    @event = Event.find(params[:id])
    @attendee = @event.attendees.create(user_id:current_user.id)
    @count = @event.attendees.size
    
    else
    redirect_to login_path
    end
  end
  
  def unattend
    @event = Event.find(params[:id])
    @count = @event.attendees.size
    @attendee = @event.attendees.find_by(user_id:current_user.id).destroy
  end
  
  def update
    if @event.update(event_params)
    flash[:success] = "イベントを保存しました"
    redirect_to events_path
    else
    render 'edit'
    end
  end
  
  def destroy
    @event.destroy
    flash[:warning] = "イベントを削除しました"
    redirect_to events_path
  end
  
  private
  def event_params
    params.require(:event).permit(:place, :time)
  end
  
  def set_event
    @event = Event.find(params[:id])
  end
end
