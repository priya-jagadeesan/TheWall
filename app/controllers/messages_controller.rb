class MessagesController < ApplicationController
    def index
        if !current_user
            redirect_to "/users"
        end
        @messages = Message.all.order(created_at: :desc)
    end

    def new
        if !current_user
            redirect_to "/users"
        end
    end

    def create
        if !current_user
            redirect_to "/users"
        end
        @message = Message.new(msg_params)
        @message.user = current_user
        if @message.save
            redirect_to "/messages"
        else
            # fail
            flash[:hasError] =  'has-error'
            flash[:message_errors] = @message.errors
            redirect_to "/messages"
        end
    end

    def show
        if !current_user
            redirect_to "/users"
        end
    end

    def edit
        if !current_user
            redirect_to "/users"
        end
    end

    def update
        if !current_user
            redirect_to "/users"
        end
    end

    def destroy
        if !current_user
            redirect_to "/users"
        end
        session[:user_id] = nil
        redirect_to '/users'
    end

    private
    def msg_params
        params.require(:message).permit(:content)
    end

    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
end
