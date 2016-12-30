module Components.Enclave exposing (..)

import Html exposing (Html, section, div)
import Html.Attributes exposing (class, style)
import Svg exposing (svg, g, circle)
import Svg.Attributes exposing (r, height, width, transform)


-- enclave component—flow content into a bounded area


enclave : Int -> List (Html msg) -> Html msg
enclave param content =
    -- assume for now shape is a circle
    let
        radius =
            param + 10

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
            , section [ class "flow" ] content
            ]
