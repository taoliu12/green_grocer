require 'pry'

def consolidate_cart(cart)

  # binding.pry
  organized_cart = {}
  count = 0
  cart.each do |element|
    element.each do |fruit, hash|
      # binding.pry
      organized_cart[fruit] ||= hash
      # binding.pry
      organized_cart[fruit][:count] ||= 0
      # binding.pry
      organized_cart[fruit][:count] += 1
    end
    # binding.pry
  end
  return organized_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item] && (cart[item][:count] >= coupon[:num])
      if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"][:count] += coupon[:num] 
      else
        cart["#{item} W/COUPON"] = {} #make empty hash and set it with values
        cart["#{item} W/COUPON"][:count] = coupon[:num] 
        cart["#{item} W/COUPON"][:price] = coupon[:cost] / coupon[:num]
        cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance] 
      end
      cart[item][:count] -= coupon[:num] #subtract the difference of coupon count from item count 
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |name, details|
     # binding.pry
    details[:price] = (details[:price] * 0.8).round(2) if details[:clearance] == true
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
   # binding.pry
  total = cart.values.reduce(0) {|sum, item| sum + (item[:price]*item[:count]).round(2)}
  if total > 100
     # binding.pry
    total = (total * 0.9).round(2)
  end
  total
end
