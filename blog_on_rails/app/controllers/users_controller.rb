class UsersController < ApplicationController
    #before_action :authorize_user!, only: [:edit, :update, :edit_password, :change_password]
    def new
        @user=User.new
    end
    def create 
        @user = User.new(user_params)
        if @user.save
            #session[:user_id] = @user.id
            redirect_to root_path, notice: 'Logged in'
        else
            render :new
        end
    end
    def edit
        #@user = User.find params[:id]
        @user=current_user
    end
    def update
        @user = current_user
       
            if @user.update params.require(:user).permit(
                :name,
                :email    
            )
                redirect_to root_path, notice: 'Acount updated'
            else
                render :edit
            end
        
    end

    def edit_password
        
        @user = User.find params[:id]
        @user = current_user
    end
    def change_password
        @user = current_user
        if(@user.authenticate(params[:user][:current_password]))
            if(params[:user][:current_password]!=params[:user][:new_password])&&(params[:user][:new_password]==params[:user][:new_password_confirmation])
               
               if @user.update(password:params[:user][:new_password])
                flash[:notice] =  "Password changed  "
                redirect_to root_path 
               else
                flash[:notice] =  "Passwords dosen't match  "
                render  edit_password_path(@user)
               end
            else
                
                render  edit_password_path(@user)
            end
        else

            flash[:alert]=  "wrong password "
            redirect_to root_path
        end

    end

   
    

    def user_params
        params.require(:user).permit(
            :name,
            :email,
            :password,
            :password_confirmation
        )
    end
 
    def authorize_user!
       @user = User.find params[:id]
        redirect_to root_path, alert: "Not Authorized!" unless can?(:crud, @user)
    end
   
    
end
