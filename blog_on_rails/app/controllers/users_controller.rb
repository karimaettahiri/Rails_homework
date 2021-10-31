class UsersController < ApplicationController
    
    def new
        @user=User.new
    end
    def create 
        @user = User.new(user_params)
        if @user.save
            
            redirect_to root_path, notice: 'Logged in'
        else
            render :new
        end
    end
    def edit
        @user = User.find params[:id]
        #@user=current_user
    end
    def update
        @user = User.find params[:id]
        if @user.id == current_user.id
        
       
            if @user.update params.require(:user).permit(
                :name,
                :email    
            )
                redirect_to root_path, notice: 'Acount updated'
            else
                render :edit
            end
        else
            redirect_to root_path, alert: "Not Authorized!"
            
        end
        
    end

    def edit_password
        @user = current_user
    end
    def change_password
        @user = current_user
        if(@user.authenticate(params[:user][:current_password]))
            if(params[:user][:current_password]!=params[:user][:new_password])&&(params[:user][:new_password]==params[:user][:new_password_confirmation])
               
               if @user.update(password:params[:user][:new_password])
                redirect_to root_path, notice: 'password changed'
               else
                render  edit_password_path(@user), notice: 'please renter a new password'
               end
            else
                render  edit_password_path(current_user), notice: 'passwords not matched'
            end
        else

            redirect_to root_path, notice: 'wrong password'
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
 
   
   
    
end
