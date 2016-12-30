module Main exposing (..)

import Html exposing (Html, p, div, span, button, text, dl, dd, dt)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, on)
import DOM exposing (target, boundingClientRect)
import Json.Decode exposing (Decoder)


-- component import example

import Components.Enclave exposing (enclave)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { size : Int
    , actualSize : DOM.Rectangle
    }


initialModel : Model
initialModel =
    { size = 72
    , actualSize =
        { top = 0.0
        , left = 0.0
        , width = 0.0
        , height = 0.0
        }
    }



-- UPDATE


type Msg
    = NoOp
    | Increment
    | Reset
    | Measure DOM.Rectangle


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Increment ->
            { model | size = model.size + 16 }

        Reset ->
            { model | size = 72 }

        Measure rect ->
            { model | actualSize = rect }



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


decode : Decoder DOM.Rectangle
decode =
    target boundingClientRect


view : Model -> Html Msg
view model =
    let
        radius =
            model.size
    in
        div [ class "container" ]
            [ enclave radius content
            , button [ onClick Increment ] [ text "Larger" ]
            , button [ onClick Reset ] [ text "Reset" ]
            , Html.map Measure
                (button [ on "click" decode ] [ text "Measure" ])
            , dl []
                [ dt [] [ text "Width" ]
                , dd [] [ text (toString model.actualSize.width) ]
                , dt [] [ text "Height" ]
                , dd [] [ text (toString model.actualSize.height) ]
                ]
            ]
