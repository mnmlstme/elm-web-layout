module Components.Enclave
    exposing
        ( view
        , State
        , initialLayout
        , props
        )

import Html exposing (Html, section, div)
import Html.Attributes exposing (class, style)
import Html.Events as E
import Svg exposing (svg, g, circle)
import Svg.Attributes exposing (r, height, width, transform)
import DOM exposing (boundingClientRect)
import Json.Decode as Json


type alias State =
    { bbox : DOM.Rectangle
    }


initialLayout : State
initialLayout =
    State (DOM.Rectangle 0 0 0 0)


type Props msg
    = Props
        { size : Int
        , toMsg : State -> msg
        }


props : (State -> msg) -> Int -> Props msg
props msg size =
    Props { size = size, toMsg = msg }



-- TODO: create PR for elm-dom:


currentTarget : Json.Decoder a -> Json.Decoder a
currentTarget decoder =
    Json.field "currentTarget" decoder


decodeLayout : Json.Decoder DOM.Rectangle
decodeLayout =
    currentTarget boundingClientRect



-- enclave component—flow content into a bounded area


view : Props msg -> List (Html msg) -> Html msg
view (Props { size, toMsg }) content =
    -- assume for now shape is a circle
    let
        radius =
            size

        onClick =
            E.on "click" <|
                Json.map toMsg <|
                    Json.map State <|
                        decodeLayout

        rs =
            toString radius

        ds =
            toString (2 * radius)

        dim =
            ds ++ "px"

        bg =
            svg []
                [ g [ transform ("translate(" ++ rs ++ "," ++ rs ++ ")") ]
                    [ circle [ r rs ] []
                    ]
                ]

        rightPath =
            "M0 0L"
                ++ ds
                ++ " 0"
                ++ "L"
                ++ ds
                ++ " "
                ++ ds
                ++ "L0 "
                ++ ds
                ++ "A"
                ++ rs
                ++ " "
                ++ rs
                ++ " 0 0 0 0 0 "
                ++ "Z"

        leftPath =
            "M0 0L"
                ++ ds
                ++ " 0"
                ++ "A"
                ++ rs
                ++ " "
                ++ rs
                ++ " 0 0 0 "
                ++ ds
                ++ " "
                ++ ds
                ++ "L0 "
                ++ ds
                ++ "Z"

        urlSvgStart =
            "url('data:image/svg+xml,<svg xmlns=\"http://www.w3.org/2000/svg\">"

        urlSvgEnd =
            "</svg>')"

        leftShape =
            urlSvgStart
                ++ "<path d=\""
                ++ leftPath
                ++ "\"/>"
                ++ urlSvgEnd

        rightShape =
            urlSvgStart
                ++ "<path d=\""
                ++ rightPath
                ++ "\"/>"
                ++ urlSvgEnd
    in
        div
            [ class "textShape"
            , style
                [ ( "height", dim )
                , ( "width", dim )
                ]
            ]
            [ div
                [ class "textShape-left"
                , style [ ( "shapeOutside", leftShape ) ]
                ]
                []
            , div
                [ class "textShape-right"
                , style [ ( "shapeOutside", rightShape ) ]
                ]
                []
            , bg
            , section
                [ class "flow"
                , onClick
                ]
                content
            ]
