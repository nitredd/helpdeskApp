class IssuesController < ApplicationController
  before_action :require_login
  before_action :set_issue, only: %i[ show edit update destroy ]

  # GET /issues or /issues.json
  def index
    @offset = (params.key? 'offset') ? params['offset'].to_i : 0
    @pagesize = 5
    @limit = @pagesize

    @issues = Issue.where("status <> 'Closed'")
    @issues = @issues.offset(@offset).limit(@limit+1)
    @issues = @issues.to_a

    @has_more = false
    if @issues.length > @limit
      @issues.pop
      @has_more = true
    end
  end

  def closed
    @offset = (params.key? 'offset') ? params['offset'].to_i : 0
    @pagesize = 5
    @limit = @pagesize

    @issues = Issue.where("status = 'Closed'")
    @issues = @issues.offset(@offset).limit(@limit+1)
    @issues = @issues.to_a

    @has_more = false
    if @issues.length > @limit
      @issues.pop
      @has_more = true
    end

    render 'index'
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new(reporter: current_user.email)
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:summary, :body, :status, :reporter, :assigned_to)
    end
end
