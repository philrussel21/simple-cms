class PagesController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'admin', only: [:new, :edit, :delete]

  # def index
  #   @pages = Page.all.order("position ASC")
  # end

  def show
    @page = Page.find(params[:subject_id])
  end

  def new
    @new_page = Page.new()
    @subjects = subject_names_with_id(Subject.all)
  end

  def create
    @new_page = Page.new(page_params)
    if @new_page.save
      redirect_to(subject_path(@new_page.subject_id))
    else
      new
      render('new')
    end
  end

  def edit
    @subjects = subject_names_with_id(Subject.all)
    @edit_page = Page.find(params[:subject_id])
  end

  def update
    @edited_page = Page.find(params[:subject_id])

    if @edited_page.update(page_params)
      redirect_to(subject_page_path(@edited_page))
    else
      edit
      render('edit')
    end
  end

  def delete
    @delete_page = Page.find(params[:subject_id])
  end

  def destroy
    @delete_page = Page.find(params[:subject_id])
    @delete_page.destroy
    redirect_to(subject_path(@delete_page.subject_id))
  end

  private
  
  def subject_names_with_id(subjects)
    subject_names_and_id = subjects.map{|subject| [subject[:name], subject[:id]]}
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink, :content)
  end


end
