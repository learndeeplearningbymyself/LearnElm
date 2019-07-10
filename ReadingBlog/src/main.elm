import Html exposing (Html, div, text)
import Html.Attributes

main : Html msg
main =
    Html.a [ Html.Attributes.href "google.com" ] [ text "Google" ]
