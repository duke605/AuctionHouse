class ItemsController < ApplicationController
  def index
    @items = Item.where(offer_type: 'selling')
  end
end
