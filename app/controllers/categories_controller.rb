class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    
    def index
        @categories = Category.all
    
    end

    def new 
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            flash[:success] =  "Category saved successfully"
            redirect_to @category
            
        else
            render 'new'

        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "You have successfully updated the category"
            redirect_to category_path(@category)
        else
            render 'edit'
        end

    end


    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles
    
    end

    private

    def category_params
        params.require(:category).permit(:name)

    end

    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)

            flash[:danger] = "Only admins can perform that action"
            redirect_to categories_path
        end
    end
end