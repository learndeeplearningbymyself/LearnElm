module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Browser exposing (sandbox)

type alias Model = {
    players : List Player,
    name : String,
    playerId : Maybe Int,
    plays : List Play }

type alias Player = {
    id : Int,
    name : String,
    points : Int }

type alias Play = {
    id : Int,
    playerId : Int,
    name : String,
    points : Int }

initModel : Model
initModel =
    {
        players = [],
        name = "",
        playerId = Nothing,
        plays = []
    }

-- Update

type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }
        Cancel ->
            { model | name = "", playerId = Nothing }
        Save ->
            if (String.isEmpty model.name) then
                model
            else
                save model
        Score playerIns points ->
            score model playerIns points
        
        Edit playerIns ->
            { model | name = playerIns.name, playerId = Just playerIns.id }

        DeletePlay playIns ->
            deletePlay model playIns

-- View

view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score Keeper" ],
           playerSection model,
           playerForm model,
           playSection model
        ]

playSection : Model -> Html Msg
playSection model =
    div []
        [ playListHeader,
          playList model ]

playListHeader : Html Msg
playListHeader =
    header []
        [ div [] [ text "Plays" ],
          div [] [ text "Points" ]
        ]

playList : Model -> Html Msg
playList model =
    model.plays
        |> List.map play
        |> ul []

play : Play -> Html Msg
play playIns =
    li []
        [ i
            [ class "remove",
              onClick (DeletePlay playIns)] [],
          div [] [ text playIns.name ],
          div [] [ text (String.fromInt playIns.points) ]
        ]

playerSection : Model -> Html Msg
playerSection model =
    div []
        [ playerListHeader,
          playerList model,
          pointTotal model 
        ]

playerListHeader : Html Msg
playerListHeader =
    header []
        [ div [] [ text "Name" ],
          div [] [ text "Points" ]
        ]

playerList : Model -> Html Msg
playerList model =
    -- ul []
    --     (List.map player model.players)
    model.players
        |> List.sortBy .name
        |> List.map player
        |> ul []

player : Player -> Html Msg
player playerIns =
    li []
        [ i
            [ class "edit",
              onClick (Edit playerIns)
            ] [],
          div [] [ text playerIns.name ],
          button [ type_ "button", onClick (Score playerIns 2) ] [ text "2pt" ],
          button [ type_ "button", onClick (Score playerIns 3) ] [ text "3pt" ],
          div [] [ text (String.fromInt playerIns.points) ]
        ]

pointTotal : Model -> Html Msg
pointTotal model =
    let
        total = List.map .points model.plays
            |> List.sum    
    in
        footer []
            [ div [] [ text "Total: " ],
              div [] [ text(String.fromInt total) ]
            ]

playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input
            [ type_ "text",
              placeholder "Add/Edit Player...",
              onInput Input,
              value model.name 
            ]
            [],
            button [ type_ "Submit" ] [ text "Save" ],
            button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ]

add : Model -> Model
add model =
    let
        playerIns = Player (List.length model.players) model.name 0

        newPlayers = playerIns :: model.players
    in
        { model
            | players = newPlayers, name = ""
        }

edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map(\playerIns -> 
                if playerIns.id == id then
                    { playerIns | name = model.name }
                else
                    playerIns
                ) model.players
        newPlays =
            List.map(\playIns -> 
                if playIns.playerId == id then
                    { playIns | name = model.name }
                else
                    playIns
                ) model.plays
    in
        {
            model
            | players = newPlayers,
            plays = newPlays,
            name = "",
            playerId = Nothing
        }

save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id
        Nothing ->
            add model

score : Model -> Player -> Int -> Model
score model scorer points =
    let
        newPlayers =
            List.map(\playerIns -> 
                        if playerIns.id == scorer.id then
                            {
                                playerIns
                                    | points = playerIns.points + points
                            }
                        else
                            playerIns
            ) model.players

        playIns = Play (List.length model.plays) scorer.id scorer.name points
    in
        { model | players = newPlayers, plays = playIns :: model.plays }

deletePlay : Model -> Play -> Model
deletePlay model playIns =
    let
        newPlays =
            List.filter(\p -> p.id /= playIns.id) model.plays

        newPlayers =
            List.map(\playerIns ->
                        if playerIns.id == playIns.playerId then
                            { playerIns | points = playerIns.points - 1 * playIns.points }
                        else
                            playerIns
                    ) model.players
    in
        { model | plays = newPlays, players = newPlayers }

main =
    Browser.sandbox
    {
        init = initModel,
        view = view,
        update = update
    }