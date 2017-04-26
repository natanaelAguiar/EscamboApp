class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only:[:update, :edit]

  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end

  def create
    @category = CategoryService.create(category_params)

    unless @category.errors.any?
        redirect_to backoffice_categories_path, notice: "A Categoria #{@category.description} " << I18n.t('menssages.save_success')
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
