class CommentsController < ApplicationController
  def index

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
    @comment = Comment.new(msg_params)
    @comment.user = current_user
    @comment.message = Message.find(params[:message_id])
    if @comment.save
        redirect_to "/messages"
    else
        # fail
        flash[:hasError] =  'has-error'
        flash[:comment_errors] = @comment.errors
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
    end

private
def msg_params
    params.require(:comment).permit(:content)
end

def current_user
    User.find(session[:user_id]) if session[:user_id]
end
end
