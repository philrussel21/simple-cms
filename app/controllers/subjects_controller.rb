class SubjectsController < ApplicationController
  def index
    @subjects = Subject.order("position ASC")
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    # This action can be left blank since it would be creating a new record in the database.
    # Creating a new instance of the class however make sure that the form displayed would
    # pre-set default conditions you might have set up in the database. Another reason is
    # you can set a default value to the new record to be created by passing the attribute
    # and the desired value as args for .new
    #@new_subject = Subject.new(visible: false) would set the visible to false in the rendered
    #form
    @new_subject = Subject.new
  end

  def create
    #Instantiate a new object using form parameters
    @new_subject = Subject.new(subject_params)
    # @new_subject = Subject.new(params[:subject]) -> this would just do a mass assignment and would
    #raise an error. Rails by default does not allow mass assignment to objects unless attributes
    #are permitted using the permit method.

    # Save object
    if @new_subject.save
      #if save succeeds, redirect to the index action/page
      # redirect_to(action: 'index')
      redirect_to(subjects_path)
    else
    # if save fails, redisplay the form so user can fix problems
      render('new')
      #this would not call the new action from this file, this would render the 'new' template
      #from the views directory.
    end
  end

  def edit
    #grabs the record to be edited from the database
    #which would then be displayed in the form of 'edit' template
    @edit_subject = Subject.find(params[:id])
  end

  def update
    #grabs the record to be edited from the database
    @edit_subject = Subject.find(params[:id])

    #updates attribute-values of the grabbed record as long as permitted which should return a bool
    if @edit_subject.update(subject_params)
      redirect_to(subject_path(@edit_subject)) #redirects to the show page of the record
    else
      render('edit') #renders the edit template again
    end
  end

  def delete
    #grabs the record to be deleted which is then shown to the user for confirmation
    @delete_subject = Subject.find(params[:id])
  end

  def destroy
    #grabs the record to be deleted
    @delete_subject = Subject.find(params[:id])
    @delete_subject.destroy
    redirect_to(subjects_path)
  end

  private
    def subject_params
      params.require(:subject).permit(:name, :position, :visible)
      #requires the subject object to be filled and allows mass assignment to name, positon and
      #visible attributes.
    end
end
