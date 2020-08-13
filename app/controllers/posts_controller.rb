class PostsController < ApplicationController

    get '/posts' do
        # checking user authentication with helper method
        if logged_in?
            @posts = Post.all
            erb :'posts/index'
        else
            redirect '/login'
        end
    end 

    get '/posts/new' do
        erb :'posts/new'
    end

    post '/posts' do
        # using AR association method to make a new post through it's association to a user
        @post = current_user.posts.build(params)
        # .save triggers model validation check and conditional handles a failed validation
        if @post.save
            redirect '/posts'
        else
            erb :'posts/new'
        end
    end

    get '/posts/:id/edit' do
        get_post
        # conditional checks whether the current user is authorized to edit
        if @post.user == current_user
            erb :'posts/edit'
        else
            redirect '/posts'
        end
    end
    
    patch '/posts/:id' do
        get_post
        if @post.user == current_user # authorization check
            if @post.update(content: params[:content]) # model validation check
                redirect '/posts'
            else
                erb :'posts/edit'
            end
        else
            redirect '/posts'
        end
    end

    delete '/posts/:id' do
        get_post
        if @post.user == current_user
            @post.delete
        end
        redirect '/posts'
    end

    private

    def get_post
        @post = Post.find_by_id(params[:id])
    end

end