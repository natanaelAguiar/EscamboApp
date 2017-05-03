class Backoffice::AdminsController < BackofficeController

    before_action :set_admin, only: [:edit, :update, :destroy]
    after_action :verify_authorized, only: [:new, :destroy]
    after_action :verify_policy_scoped, only: :index

    def index
        @admins = policy_scope(Admin)
    end

    def new
        @admin = Admin.new
        authorize @admin
    end

    def create
        @admin = Admin.create(params_admin)

        if @admin.save
            redirect_to backoffice_admins_path, notice: "O Administador #{@admin.email} " << I18n.t('menssages.save_success')
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @admin.update(params_admin)
            AdminMailer.update_email(current_admin, @admin).deliver_now
            redirect_to backoffice_admins_path, notice: "O Administador #{@admin.email} foi atualizado com sucesso!"
        else
            render :edit
        end
    end

    def destroy
        authorize @admin
        admin_email = @admin.email
        if @admin.destroy
            redirect_to backoffice_admins_path, notice: "O Administador #{admin_email} foi deletado com sucesso!"
        else
            render :index
        end
    end

    private

    def set_admin
        @admin = Admin.find(params[:id])
    end

    def params_admin
        passwd = params[:admin] [:password]
        passwd_confirmation = params[:admin] [:password_confirmation]

        if passwd.blank? && passwd_confirmation.blank?
            params[:admin].delete(:password)
            params[:admin].delete(:password_confirmation)
        end
        params.require(:admin).permit(policy(@admin).permitted_attributes)
    end
end
