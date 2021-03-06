body_roundedness = 4;

body_thickness = 3;
body_width = 65;
body_length = 100;

body_offset = 0;

upper_body_offset = 24;

raspi_width = 56;
raspi_length = 85.6;
raspi_height = 21;
raspi_base = 3.6;
raspi_offset_y = 0.35;

raspi_holes = [
    [24.5, 39],
    [-24.5, 39],
    [24.5, -19],
    [-24.5, -19]
];

servo_holes = [
    [-14, -5],
    [-14, -15],
    [35, -5],
    [35, -15]
];

raspi_hole_size = 3.5;

servo_width = 40;
servo_length = 35;
servo_height = 20;

servo_spread = 6;
servo_pos = 20;

wheel_diameter = 56;
wheel_thickness = 5;
wheel_offset = 16.5;
wheel_pos = 20;

support_wheel_radius =
      wheel_diameter/2
    - servo_height/2
    - body_thickness/2;
    
support_wheel_pos = -30;

module tubes() {
    linear_extrude(
        height = 3
    ) {
        for (hole = raspi_holes) {
            translate(hole)
            difference() {
                circle(d = raspi_hole_size + 1, $fn=30);
                circle(d = raspi_hole_size, $fn=30);
            }
        }
    }
}


module body_shape() {
        difference() {
            offset(r = body_roundedness) {
                scale([
                    body_width - 2*body_roundedness,
                    body_length - 2*body_roundedness
                ])
                square(1, center = true);
            }
            for (hole = raspi_holes) {
                translate(hole)
                circle(d=raspi_hole_size, $fn=30);
            }
    }
}


module body() {
    linear_extrude(
        height = body_thickness
    ) {
        body_shape();
    }
}

module support_wheel() {
    wheel_width=10;
    
    translate([0,0,-support_wheel_radius/2])
    color("black")
    rotate([0,90,0])
    cylinder(h=wheel_width, d=support_wheel_radius, center=true);
    
    translate([wheel_width/2,-support_wheel_radius/2,0])
    rotate([0,90,0])
    color("silver")
    linear_extrude(
        height=2
    ) {
      polygon([
        [0,0],
        [0,support_wheel_radius],
        [support_wheel_radius/2, support_wheel_radius/2]
      ]);
    }
    
    translate([-wheel_width/2 - 2,-support_wheel_radius/2,0])
    rotate([0,90,0])
    color("silver")
    linear_extrude(
        height=2
    ) {
      polygon([
        [0,0],
        [0,support_wheel_radius],
        [support_wheel_radius/2, support_wheel_radius/2]
      ]);
    }
}

module spacer(hole_pos) {
    difference() {
        translate([-2,
                    1,
                    upper_body_offset/2
                    + body_offset/2])
        scale([11, 12, servo_height
                        + upper_body_offset
                        + body_offset])
        cube(center=true);
        
        translate([0, -hole_pos, 0])
        cylinder(
            h=servo_height+2*upper_body_offset + 4,
            d=raspi_hole_size,
            center=true,
            $fn=36);
        
        translate([0, 3.2, -5.1])
        rotate([0, 90, 0])
        cylinder(
            h=20,
            d=3.5,
            center=true,
            $fn=36);
            
        translate([2, -3, 0])
        scale([10,10,4])
        cube(center=true);
        
        translate([2, -3, 24])
        scale([10,10,4])
        cube(center=true);
        
        translate([0, 3.2, 5.1])
        rotate([0, 90, 0])
        cylinder(
            h=20,
            d=3.5,
            center=true,
            $fn=36);
    }
}

module spacer1() {
    spacer(0.95);
}

module spacer2() {
    scale([-1,1,1]) spacer(0.95);
}

// rotate( [ 90, 0, 0 ] ) {
rotate( [30, 0, 0] ) rotate ( [0, 0, 45] ){
// rotate( [30, 0, 0] ) rotate ( [0, 0, 135] ){

// rotate( [-30, 0, 0] ) rotate ( [0, 0, 45] ){

for (hole_xy = raspi_holes) {
    color("silver")
    translate([hole_xy[0], hole_xy[1], 12.5])
    import("m3nut.stl");
    color("silver")
    translate([hole_xy[0], hole_xy[1], -3.1])
    scale([1,1,-1])
    import("m3x20.stl");
    color("silver")
    translate([hole_xy[0], hole_xy[1], -12])
    import("m3nut.stl");
    color("silver")
    translate([hole_xy[0], hole_xy[1], 11.4])
    import("m3x20.stl");
}

for (hole_yz = servo_holes) {
    color("silver")
    translate([18.5, hole_yz[0], hole_yz[1]])
    rotate([0, 90, 0])
    import("m3nut.stl");
    color("silver")
    translate([14, hole_yz[0], hole_yz[1]])
    rotate([0, 90, 0])
    import("m3x20.stl");
    color("silver")
    translate([-20.9, hole_yz[0], hole_yz[1]])
    rotate([0, 90, 0])
    import("m3nut.stl");
    color("silver")
    translate([-14, hole_yz[0], hole_yz[1]])
    rotate([0, -90, 0])
    import("m3x20.stl");
}

translate([-24.5, -17.5, -servo_height/2 - body_offset])
color("pink")
spacer1();

translate([24.5, -17.5, -servo_height/2 - body_offset])
color("pink")
spacer2();

translate([-24.5, 38, -servo_height/2 - body_offset])
rotate([0,0,180])
color("pink")
spacer2();

translate([24.5, 38, -servo_height/2 - body_offset])
rotate([0,0,180])
color("pink")
spacer1();


translate([0,0,-servo_height - body_thickness - body_offset])
body();
 
translate([0,0,upper_body_offset])
body();

translate([
    raspi_width/2 + wheel_thickness + wheel_offset,
    wheel_pos,
    -body_thickness - servo_height/2 - body_offset
])
rotate([0, 90, 0])
color("grey")
cylinder(h=wheel_thickness, r=wheel_diameter/2, center=true);

translate([
    -raspi_width/2 - wheel_thickness - wheel_offset,
    wheel_pos,
    -body_thickness - servo_height/2 - body_offset
])
rotate([0, 90, 0])
color("grey")
cylinder(
    h=wheel_thickness,
    r=wheel_diameter/2,
    center=true
);

color("pink")
translate(
    [0,
     0,
     upper_body_offset + body_thickness + 0.1
])
tubes();

translate([
    0,
    support_wheel_pos,
    -(servo_height + body_thickness + body_offset)
])
support_wheel();


translate([
    raspi_width/2,
    -raspi_length/2 + raspi_offset_y,
    upper_body_offset+body_thickness+raspi_base
])
rotate([0,0,90])
color("green")
import("raspberrypi2.stl");

translate([
    -servo_spread,
    servo_pos,
    -(servo_height/2) - body_offset
])
scale([10, -9.9, 10])
rotate([0,90,90])
color("blue")
import("standardservo.stl");

translate([
    servo_spread,
    servo_pos,
    -(servo_height/2) - body_offset
])
scale([-10, -9.9, 10])
rotate([0,90,90])
color("blue")
import("standardservo.stl");

}