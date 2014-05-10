require 'sinatra'
require './boot.rb'
require './money_calculator.rb'
# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end

get '/about' do
  erb :about
end

get '/' do
  @products = Item.all
  @random_products = @products.sample(10)
  erb :index
end

get '/products' do
  @products = Item.all
  erb :products
end

get '/buy_product/:id' do
  @products = Item.find(params[:id])
  erb :buy_product2
end

post '/buy_product/:id' do
  @products = Item.find(params[:id])
  @calc = MoneyCalculator.new params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands]
  @amount_due = params[:quantity].to_i*@products.price
  if (@calc.total<@amount_due || params[:quantity].to_i>@products.quantity) 
    erb :failed
  else
    @calc.change(@amount_due, @calc.total)
    @product = Item.find(params[:id])
    @product.update_attributes!(
    quantity: @product.quantity-params[:quantity].to_i, 
    sold: @product.sold + params[:quantity].to_i)
    erb :success
  end
end

# ROUTES FOR ADMIN SECTION
