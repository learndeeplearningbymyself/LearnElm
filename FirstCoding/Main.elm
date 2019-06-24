module Main exposing (..)

import Html
import String
import Basics

-- add a b =
--     a + b

-- result =
--     add 1 2 |> \a -> Basics.modBy a 2 == 0

-- counter = 0

-- increment cnt amt =
--     let localCount = cnt
--     in
--         localCount = localCount + 1

-- main = Html.text ""

type alias Item = {
    name : String,
    price : Float,
    qty : Int,
    discounted : Bool }

cart : List { name : String, price : Float, qty : Int, discounted : Bool }
cart =
    [ { name = "Lemon", price = 0.5, qty = 1, discounted = False },
      { name = "Apple", price = 1.0, qty = 5, discounted = False },
      { name = "Pear", price = 1.25, qty = 10, discounted = False }]

-- fiveOrMoreDiscount item =
--     if item.qty >= 5 then
--         { item
--             | price = item.price * 0.8,
--             discounted = True
--         }
--     else
--         item

discount : Int -> Float -> Item -> Item
discount minQty discPct item =
    if not item.discounted && item.qty >= minQty then
        {item
            | price = item.price * (1.0 - discPct),
            discounted = True}
    else
        item

newCart : List Item
newCart =
    List.map ((discount 10 0.3) >> (discount 5 0.2)) cart

main =
    Html.text (Debug.toString newCart)
