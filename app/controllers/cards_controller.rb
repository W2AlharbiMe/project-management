class CardsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :get_user_data
    before_action :find_card, except: [:index, :new, :create]

    def index
        @cards = @data[1].cards.sorted
    end

    def show
    end

    def new
        @card = @data[1].cards.new
    end

    def create
        @card = @data[1].cards.create(card_params)
        redirect_to org_project_path(params[:org_id], params[:project_id])

        # respond_to do |format|
        #     format.html { render org_project_path(params[:org_id], params[:project_id]) }
        # end
    end

    def edit
    end

    def update
        @card.update(card_params)

        respond_to do |format|
            format.html
            format.json  { render :json => @card } # don't do msg.to_json
          end
    end

    def destroy
        @card.destroy
        respond_to do |format|
            format.html
            format.json  { render :json => @card } # don't do msg.to_json
          end
    end

    private
    def find_card
        @card = @data[1].cards.find(params[:id])
    end

    def card_params
        params.require(:card).permit(:title)
    end
end
