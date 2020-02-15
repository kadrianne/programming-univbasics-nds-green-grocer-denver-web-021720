collection =    [
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

coupons =     [
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


      avocado = find_item_by_name_in_collection('AVOCADO', collection)
      cart = [avocado, avocado, find_item_by_name_in_collection('CHEESE', collection)]

def consolidate_cart(cart)
  i = 0
  new_cart = []
  while i < cart.length do
    item_name = cart[i][:item]
    item_new_cart = find_item_by_name_in_collection(item_name, new_cart)
    if item_new_cart  == nil # if item name is not found in new_cart, add item with :count => 1
      new_item_info = find_item_by_name_in_collection(item_name, cart)
      new_item_info[:count] = 1
      new_cart << new_item_info
    else # if item name is found in new_cart, increase count by 1
      item_new_cart[:count] += 1
    end
    i += 1
  end
  new_cart
end
 
def apply_coupons(cart, coupons)
  cart = consolidate_cart(cart)
  i = 0
  while i < cart.length do
    item_name = cart[i][:item]
    item_info = find_item_by_name_in_collection(item_name, cart)
    coupon = find_item_by_name_in_collection(item_name, coupons)
    if coupon != nil && coupon[:num] <= item_info[:count]
      item_w_coupon = {
        item: "#{item_name} W/ COUPON",
        price: (coupon[:cost] / coupon[:num]),
        clearance: item_info[:clearance],
        count: coupon[:num]
      }
      item_info[:count] -= coupon[:num] # decrease item count
      cart << item_w_coupon
      if item_info[:count] = 0
         cart.delete(item_info)
      end
    end
    i += 1
  end 
  cart
end
pp apply_coupons(cart, coupons)