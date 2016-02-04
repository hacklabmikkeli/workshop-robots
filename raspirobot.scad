
body_thickness = 2;
body_width = 66;
body_length = 100;

raspi_width = 56;
raspi_length = 85.6;
raspi_height = 21;
raspi_base = 1;

raspi_holes = [
    [24.5, 39],
    [-24.5, 39],
    [24.5, -19],
    [-24.5, -19]
];

raspi_hole_size = 2;

servo_width = 40;
servo_length = 35;
servo_height = 20;

servo_spread = 3;
servo_pos = 20;

wheel_diameter = 56;
wheel_thickness = 5;
wheel_offset = 12;
wheel_pos = 20;

support_wheel_height = 30;
support_wheel_width = 10;
support_wheel_thickness = 30;
support_wheel_pos = 50;

module body_shape() {
    difference() {
        scale([body_width, body_length])
            square(1, center = true);
        for (hole = raspi_holes) {
            translate(hole)
                circle(raspi_hole_size);
        }
    }
}

translate([0,0,-servo_height - body_thickness])
    linear_extrude(
        height = 2
    ) {
        body_shape();
    }

linear_extrude(
    height = 2
) {
    body_shape();
}

translate([raspi_width/2 + wheel_thickness + wheel_offset, wheel_pos, -body_thickness - servo_height/2])
    rotate([0, 90, 0])
        color("grey")
            cylinder(h=wheel_thickness, r=wheel_diameter/2, center=true);
translate([-raspi_width/2 - wheel_thickness - wheel_offset, wheel_pos, -body_thickness - servo_height/2])
    rotate([0, 90, 0])
        color("grey")
            cylinder(h=wheel_thickness, r=wheel_diameter/2, center=true);
translate([raspi_width/2, -raspi_length/2, body_thickness+raspi_base])
    rotate([0,0,90])
        color("green")
            import("raspberrypi2.stl");
translate([-servo_spread, servo_pos, -(servo_height/2)])
    scale([10, -10, 10])
        rotate([0,90,90])
            color("blue")
                import("standardservo.stl");
translate([servo_spread, servo_pos, -(servo_height/2)])
    scale([-10, -10, 10])
        rotate([0,90,90])
            color("blue")
                import("standardservo.stl");
