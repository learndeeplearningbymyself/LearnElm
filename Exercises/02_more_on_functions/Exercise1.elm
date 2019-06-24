import String
import Time exposing ()

person = { name="James", age=42 }

olderPerson = { person | age = 43 }

-- Union Type

type Action = AddPlayer String | Score Int Int

action = AddPlayer "James"

msg = AddPlayer "James"

-- Pattern Matching

result = case msg of
    AddPlayer name -> "Add Player " ++ name
    Score id points -> "Player id " ++ (String.fromInt id) ++ " scored " ++ (String.fromInt points)

