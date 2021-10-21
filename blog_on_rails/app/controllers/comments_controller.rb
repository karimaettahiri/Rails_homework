class CommentsController < ApplicationController
    def create
        @post = Post.find params[:post_id]
        @comment = Comment.new(params.require(:comment).permit(:body))
        @comment.post = @post
       
        if @comment.save
           
            redirect_to post_path(@post.id)
        else
            @comments = @post.comments.order(created_at: :desc)
            render '/posts/show'
        end
        
    end

    def destroy
        @post = Post.find params[:post_id]
        @comment= Comment.find params[:id]
       
        if @comment.destroy
                flash[:success] = "Deleted"
                redirect_to post_path(@post)
        else
                redirect_to root_path, alert: "can't delete"
        end
        

        
    end
end
