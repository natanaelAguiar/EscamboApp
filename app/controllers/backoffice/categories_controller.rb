class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only:[:update, :edit]

  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
        redirect_to backoffice_categories_path, notice: "A Categoria #{@category.description} foi salva com sucesso!"
    else
        render :new
    end
  end

  def edit
  end

  def update
      if @category.update(category_params)
        redirect_to backoffice_categories_path, notice: "A Categoria #{@category.description} foi Atualizado com sucesso!"
      else
        render :new
      end
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:description)
    end
end
