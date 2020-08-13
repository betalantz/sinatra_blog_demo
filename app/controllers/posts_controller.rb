class PostsController < ApplicationController

    get '/posts' do
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
        @post = current_user.posts.build(params)
        if @post.save
            redirect '/posts'
        else
            erb :'posts/new'
        end
    end

    get '/posts/:id/edit' do
        @post = Post.find_by_id(params[:id])
        if @post.user == current_user
            erb :'posts/edit'
        else
            redirect '/posts'
        end
    end
    
    patch '/posts/:id' do
        @post = Post.find_by_id(params[:id])
        if @post.user == current_user
            if @post.update(content: params[:content])
                redirect '/posts'
            else
                erb :'posts/edit'
            end
        else
            redirect '/posts'
        end
    end

    delete '/posts/:id' do
        @post = Post.find_by_id(params[:id])
        if @post.user == current_user
            @post.delete
        end
        redirect '/posts'
    end

end