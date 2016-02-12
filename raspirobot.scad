body_roundedness = 4;

body_thickness = 3;
body_width = 65;
body_length = 100;

raspi_width = 56;
raspi_length = 85.6;
raspi_height = 21;
raspi_base = 1.3;
raspi_offset_y = 0.35;

raspi_holes = [
    [24.5, 39],
    [-24.5, 39],
    [24.5, -19],
    [-24.5, -19]
];

raspi_hole_size = 4.2;

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
    difference() {
        sphere(r=support_wheel_radius, $fa=1);
        translate([
            0,
            0,
            support_wheel_radius
        ])
        scale([
            2*support_wheel_radius,
            2*support_wheel_radius,
            2*support_wheel_radius
        ])
            cube(center=true);
        
    }
}

module spacer(hole_pos) {
    difference() {
        translate([-2, 0, 0])
            scale([11, 10, servo_height])
                cube(center=true);
        translate([-2, -8, 0])
            scale([12, 18, servo_height - 4])
                cube(center=true);
        translate([0, -hole_pos, 0])
            #cylinder(h=servo_height+12, d=raspi_hole_size, center=true, $fn=36);
        translate([0, 3.2, -5.1])
            rotate([0, 90, 0])
                cylinder(h=20, d=4.2, center=true, $fn=36);
        translate([0, 3.2, 5.1])
            rotate([0, 90, 0])
                cylinder(h=20, d=4.2, center=true, $fn=36);
        translate([1, 7, 0])
            scale([10, 8.05, servo_height])
                cube(center=true);
        translate([1, 3, 0])
            scale([10, 8.05, servo_height-4])
                cube(center=true);
    }
}

module spacer1() {
    spacer(1);
}

module spacer2() {
    union() {
        spacer(0.9);
        translate([-4.2,3.5,0])
            sphere(r=1, $fn=36);
    }
    
}


translate([
    0,
    support_wheel_pos,
    -(servo_height + body_thickness)
])
    color("white")
        support_wheel();


translate([-24.5, -17.5, -servo_height/2])
    color("pink")
        spacer1();

translate([24.5, -17.5, -servo_height/2])
    color("pink")
        scale([-1,1,1])
            spacer1();


translate([-24.5, 38, -servo_height/2])
    scale([1, -1, 1])
        color("pink")
            spacer2();

translate([24.5, 38, -servo_height/2])
    scale([-1, -1, 1])
        color("pink")
            spacer2();


translate([0,0,-servo_height - body_thickness])
    body();

body();

translate([
    raspi_width/2 + wheel_thickness + wheel_offset,
    wheel_pos,
    -body_thickness - servo_height/2
])
    rotate([0, 90, 0])
        color("grey")
            cylinder(h=wheel_thickness, r=wheel_diameter/2, center=true);
translate([
    -raspi_width/2 - wheel_thickness - wheel_offset,
    wheel_pos,
    -body_thickness - servo_height/2
])
    rotate([0, 90, 0])
        color("grey")
            cylinder(
                h=wheel_thickness,
                r=wheel_diameter/2,
                center=true
            );
translate([
    raspi_width/2,
    -raspi_length/2 + raspi_offset_y,
    body_thickness+raspi_base
])
    rotate([0,0,90])
        color("green")
            import("raspberrypi2.stl");
translate([
    -servo_spread,
    servo_pos,
    -(servo_height/2)
])
    scale([10, -9.9, 10])
        rotate([0,90,90])
            color("blue")
                import("standardservo.stl");
translate([
    servo_spread,
    servo_pos,
    -(servo_height/2)
])
    scale([-10, -9.9, 10])
        rotate([0,90,90])
            color("blue")
                import("standardservo.stl");
