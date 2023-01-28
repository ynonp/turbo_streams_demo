class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('new_message', partial: 'new_message_form')
          ]
        end
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def message_params
    params.require(:message).permit(:text)
  end
end
