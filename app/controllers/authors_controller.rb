class AuthorsController < ApplicationController
  before_filter :authenticate, :except => [ :show, :index ]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @authors }
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])
    @books = @author.items.find(:all, :order => 'title')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @author }
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    if current_user.category > 0
      @author = Author.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @author }
      end
    else
      redirect_to(authors_path)
    end
  end

  # GET /authors/1/edit
  def edit
    if current_user.category > 0
      @author = Author.find(params[:id])
    else
      redirect_to(authors_path)
    end
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])
    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, :notice => 'Author was successfully created.' }
        format.json { render :json => @author, :status => :created, :location => @author }
      else
        format.html { render :action => "new" }
        format.json { render :json => @author.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to @author, :notice => 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @author.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end
  
  def search
   @author = Author.search params[:search]
  end
  
  def authenticate
    redirect_to(new_user_session_path) unless user_signed_in?
  end
  
end
