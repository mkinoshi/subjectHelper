class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  $category_id = nil
  # GET /links
  # GET /links.json
  def index
    if !session[:temp_category].nil?
      $category_id  = session[:temp_category]
    end
    if Link.exists?(category_id: $category_id)
      @links = Link.where({category_id: $category_id})
      puts @links
    end
    session[:temp_category] = nil
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    c_id = params[:category_id]
    puts "c_id is" + params[:category_id].to_s
    session[:temp_c] = c_id
    @link = Link.new(category_id: c_id)
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    c_id = params[:c_id]
    @link = current_user.links.build(link_params)
    @link.category_id = c_id
    session[:temp_c] = nil
    puts "category_id" + @link.category_id.to_s
    respond_to do |format|
      if @link.save
        session[:temp_category] = @link.category_id
        format.html { redirect_to action: "index", notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :content, :category_id, :user_id)
    end
end
