require 'pry'
items =    [
      {:item => "AVOCADO", :price => 3.00, :clearance => true},
      {:item => "KALE", :price => 3.00, :clearance => false},
      {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
      {:item => "ALMONDS", :price => 9.00, :clearance => false},
      {:item => "TEMPEH", :price => 3.00, :clearance => true},
      {:item => "CHEESE", :price => 6.50, :clearance => false},
      {:item => "BEER", :price => 13.00, :clearance => false},
      {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
      {:item => "BEETS", :price => 2.50, :clearance => false},
      {:item => "SOY MILK", :price => 4.50, :clearance => true}
    ]
        
def find_item_by_name_in_collection(name, collection)
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    else
      nil
    end
    i += 1
  end
end

        beer = find_item_by_name_in_collection('BEER', items)
        cart = [beer, beer, beer]
        beer_coupon = coupons[1]
        coupons = [beer_coupon, beer_coupon]
        
def consolidate_cart(cart)
  i = 0
  new_cart = []
  while i < cart.length do
    item_name = cart[i][:item]
    item_new_cart = find_item_by_name_in_collection(item_name, new_cart)
    if item_new_cart  == nil # if item name is not found in new_cart, add item with :count => 1
      cart_item = find_item_by_name_in_collection(item_name, cart)
      new_item_info = {
        item: cart_item[:item],
        price: cart_item[:price],
        clearance: cart_item[:clearance]
      }
      new_item_info[:count] = 1
      new_cart << new_item_info
    else # if item name is found in new_cart, increase count by 1
      new_item_info[:count] += 1
    end
    i+=1
  end
  new_cart
end

consolidated_cart = consolidate_cart(cart)

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length
    item_name = coupons[i][:item]
    coupon_name = "#{item_name} W/COUPON"
    cart_item = find_item_by_name_in_collection(item_name, cart)
    coupon_item = find_item_by_name_in_collection(coupon_name, cart)
    if coupon_item && coupons[i][:num] >= cart_item[:count]
      binding.pry
      coupon_item[:count] += coupons[i][:num]
      cart_item[:count] -= coupons[i][:num]
    elsif !coupon_item
      coupon_item = {
      item: coupon_name,
      price: (coupons[i][:cost] / coupons[i][:num]),
      clearance: cart_item[:clearance],
      count: coupons[i][:num]
      }
      cart << coupon_item
      cart_item[:count] -= coupons[i][:num]
    else
    end
    i += 1
  end
  cart
end