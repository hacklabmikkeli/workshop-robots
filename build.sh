#!/bin/sh

openscad -o raspirobot_body_shape.svg raspirobot_body_shape.scad
openscad -o raspirobot_spacer1.stl raspirobot_spacer1.scad
openscad -o raspirobot_tube.stl raspirobot_tube.scad

# setup for laser cutter
perl -pi -e 's/<svg width="\d+" height="\d+"/<svg width="120mm" height="70mm"/' \
    raspirobot_body_shape.svg
perl -pi -e 's/viewBox="[0-9 -]*"/viewBox="-60 -35 120 70"/' \
    raspirobot_body_shape.svg
