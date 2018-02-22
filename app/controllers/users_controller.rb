class UsersController < ApplicationController
    def index
        if current_user
            redirect_to "/users/#{current_user.id}"
        end
    end

    def new
        if current_user
            redirect_to "/users/#{current_user.id}"
        end
    end

    def create
        if params[:form_value]=='register'
            @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                # redirect_to "/users/#{@user.id}"
                redirect_to "/messages"
            else
                # fail
                flash[:hasError] =  'has-error'
                flash[:hasFeedback] =  'has-feedback'
                flash[:register] = @user.errors
                redirect_to "/users/new"
            end
        elsif params[:form_value]=='sign_in'
            # fail
            @user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
            if @user
                session[:user_id] = @user.id
                # redirect_to "/users/#{@user.id}"
                redirect_to "/messages"
            else
                flash[:has_Error] =  'has-error'
                flash[:sign_in] = '*Invalid Credentials'
                redirect_to "/users/new"
            end
        end
    end

    def show
        if !current_user
            session[:user_id] = nil
            redirect_to "/users"
        end
    end

    def edit

    end

    def update
        @user = User.find(current_user.id)
        if @user.update(update_params)
            redirect_to "/users/#{current_user.id}"
        else
            flash[:edithasError] = 'has-error'
            flash[:edit] = @user.errors
            redirect_to "/users/#{current_user.id}/edit"
        end
    end

    def destroy
        @user = User.find(current_user.id)
        @user.destroy
        session[:user_id] = nil
        redirect_to "/users"
    end

    def logout
        session[:user_id] = nil
        redirect_to "/users"
    end

    private
    def user_params
        params.require(:user).permit(:dateOfBirth,:name,:password,:password_confirmation)
    end

    def update_params
        params.require(:user).permit(:dateOfBirth,:name)
    end

    def current_user
        if session[:user_id]
            return User.find(session[:user_id]) 
        end
    end
end
