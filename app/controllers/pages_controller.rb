class PagesController < ApplicationController
  def index
    @pages = Page.all.order("position ASC")
  end

  def show
    @page = Page.find(params[:subject_id])
  end

  def new
    @new_page = Page.new(position: ((Page.all).count + 1))
    @subjects = subject_names_with_id(Subject.all)
  end

  def create
    @new_page = Page.new(page_params)
    if @new_page.save
      redirect_to(pages_path)
    else
      new
      render('new')
    end
  end

  def edit
    @subjects = subject_names_with_id(Subject.all)
    @edit_page = Page.find(params[:id])
  end

  def update
    @edited_page = Page.find(params[:id])

    if @edited_page.update(page_params)
      redirect_to(page_path(@edited_page))
    else
      edit
      render('edit')
    end
  end

  def delete
    @delete_page = Page.find(params[:id])
  end

  def destroy
    @delete_page = Page.find(params[:id])
    @delete_page.destroy
    redirect_to(pages_path)
  end

  private
  
  def subject_names_with_id(subjects)
    subject_names_and_id = subjects.map{|subject| [subject[:name], subject[:id]]}
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink, :content)
  end


end
