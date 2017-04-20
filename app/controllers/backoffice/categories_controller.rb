class Backoffice::CategoriesController < BackofficeController
  def index
    @categories = Category.all
  end

  def edit

  end
end
