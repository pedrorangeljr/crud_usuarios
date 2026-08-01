class UsersController < ApplicationController
  before_action :set_user, only: %i[
    show
    edit
    update
    destroy
  ]

  def index
    @q = params[:q]

    @users = User.order(:nome)

    return unless @q.present?

    @users = @users.where(
      'LOWER(nome) LIKE :busca OR LOWER(email) LIKE :busca',
      busca: "%#{@q.downcase}%"
    )
  end

  def show
  end

  def new # quando clico no botão de novo usuario
    @user = User.new
  end

  def create # quando clica no botão salvar
    @user = User.new(user_params)

    if @user.save

      redirect_to users_path,
                  notice: 'Usuário Cadastrado'
    else

      render :new, status: :unprocessable_entity

    end
  end

  def edit
  end

  def update
    if @user.update(user_params)

      redirect_to users_path, notice: 'Usuário Atualizado'

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path, notice: 'Usuário Removido'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :nome,
      :email,
      :idade
    )
  end
end
