import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

-- Model

type alias Model =
    { input : String
    , memos : List String 
    }

init : Model
init =
    { input = ""
    , memos = []
    }

-- Update

type Msg
    = Input String
    | Submit

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }
        
        Submit ->
            {
                model
                | input = ""
                , memos = model.input :: model.memos
            }

-- View

view : Model -> Html Msg
view model =
    text ""


