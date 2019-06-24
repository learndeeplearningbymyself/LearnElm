module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Browser exposing (sandbox)

type alias Model =
    {
        calories : Int,
        input : Int,
        error : Maybe String
    }

initModel : Model
initModel =
    -- Model 0 0 Nothing -- the same meaning with constructor
    {
        calories = 0,
        input = 0,
        error = Nothing
    }

type Msg = AddCalorie | Input String | Clear

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | calories = model.calories + model.input,
                input = 0
            }
        Input val ->
            case String.toInt val of
                Just input ->
                    { model
                        |   input = input,
                            error = Nothing
                    }
                Nothing ->
                    { model
                        | input = 0,
                        error = Just "Error with value"
                    }
        Clear ->
            initModel

view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ (String.fromInt model.calories)) ]
          , input
            [ type_ "text", onInput Input, value (if model.input == 0 then "" else String.fromInt model.input) ]
            []
          , div [] [ text (Maybe.withDefault "" model.error) ]        
          , button
              [ type_ "button", onClick AddCalorie ]
              [ text "Add" ]
          , button
              [ type_ "button", onClick Clear ]
              [ text "Clear" ]
        ]

main =
   Browser.sandbox
   {
       init = initModel,
       view = view,
       update = update
   }
