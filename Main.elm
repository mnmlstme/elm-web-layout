module Main exposing (..)

import Html exposing (Html, p, div, span, button, text, dl, dd, dt)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


-- import our component

import Components.Enclave as Layout


-- APP


main : Program Never Model Msg
main =
    Html.program
        { init = init 72
        , view = view
        , update = update
        , subscriptions = (\model -> Sub.none)
        }



-- MODEL


type alias Model =
    { size : Int
    , layout : Layout.State
    }


init : Int -> ( Model, Cmd Msg )
init size =
    let
        model =
            { size = 72
            , layout = Layout.initialLayout
            }
    in
        ( model, Cmd.none )



-- UPDATE


type Msg
    = Increment
    | Reset
    | LaidOut Layout.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | size = model.size + 16 }, Cmd.none )

        Reset ->
            ( { model | size = 72 }, Cmd.none )

        LaidOut layout ->
            ( { model | layout = layout }, Cmd.none )



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


content : List (Html msg)
content =
    [ p [ class "stanza" ]
        [ span [ class "line" ] [ text "`Twas brillig, and the slithy toves" ]
        , span [ class "line" ] [ text "  Did gyre and gimble in the wabe:" ]
        , span [ class "line" ] [ text "All mimsy were the borogoves," ]
        , span [ class "line" ] [ text "  And the mome raths outgrabe." ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "\"Beware the Jabberwock, my son!" ]
        , span [ class "line" ] [ text "  The jaws that bite, the claws that catch!" ]
        , span [ class "line" ] [ text "Beware the Jubjub bird, and shun" ]
        , span [ class "line" ] [ text "  The frumious Bandersnatch!\"" ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "He took his vorpal sword in hand:" ]
        , span [ class "line" ] [ text "  Long time the manxome foe he sought --" ]
        , span [ class "line" ] [ text "So rested he by the Tumtum tree," ]
        , span [ class "line" ] [ text "  And stood awhile in thought." ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "And, as in uffish thought he stood," ]
        , span [ class "line" ] [ text "  The Jabberwock, with eyes of flame," ]
        , span [ class "line" ] [ text "Came whiffling through the tulgey wood," ]
        , span [ class "line" ] [ text "  And burbled as it came!" ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "One, two! One, two! And through and through" ]
        , span [ class "line" ] [ text "  The vorpal blade went snicker-snack!" ]
        , span [ class "line" ] [ text "He left it dead, and with its head" ]
        , span [ class "line" ] [ text "  He went galumphing back." ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "\"And, has thou slain the Jabberwock?" ]
        , span [ class "line" ] [ text "  Come to my arms, my beamish boy!" ]
        , span [ class "line" ] [ text "O frabjous day! Callooh! Callay!\"" ]
        , span [ class "line" ] [ text "  He chortled in his joy." ]
        ]
    , p [ class "stanza" ]
        [ span [ class "line" ] [ text "`Twas brillig, and the slithy toves" ]
        , span [ class "line" ] [ text "  Did gyre and gimble in the wabe;" ]
        , span [ class "line" ] [ text "All mimsy were the borogoves," ]
        , span [ class "line" ] [ text "  And the mome raths outgrabe." ]
        ]
    ]


view : Model -> Html Msg
view model =
    let
        radius =
            model.size

        given =
            Layout.props LaidOut

        bbox =
            model.layout.bbox
    in
        div [ class "container" ]
            [ Layout.view (given radius) content
            , button [ onClick Increment ] [ text "Larger" ]
            , button [ onClick Reset ] [ text "Reset" ]
            , dl []
                [ dt [] [ text "Width" ]
                , dd [] [ text (toString bbox.width) ]
                , dt [] [ text "Height" ]
                , dd [] [ text (toString bbox.height) ]
                ]
            ]
