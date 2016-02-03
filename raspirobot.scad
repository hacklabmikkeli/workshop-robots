
body_thickness = 2;
body_width = 100;
body_length = 70;

raspi_width = 56;
raspi_length = 85.6;
raspi_height = 21;

servo_width = 40;
servo_length = 35;
servo_height = 20;

servo_spread = 30;
servo_pos = 20;

wheel_diameter = 40;
wheel_thickness = 5;

support_wheel_height = 30;
support_wheel_width = 10;
support_wheel_thickness = 30;
support_wheel_pos = 50;

linear_extrude(
    height = 2
) {
    scale([body_width, body_length])
        square(1, center = true);
    translate([0, body_length / 2])
        circle(body_width / 2);
    translate([0, - body_length / 2])
        circle(body_width / 2);
}


translate([0, 0, (raspi_height/2) + body_thickness])
    scale([raspi_width, raspi_length, raspi_height])
        color("green")
            cube(1, center = true);
translate([-servo_spread, servo_pos, -(servo_height/2)])
    scale([servo_width, servo_length, servo_height])
        color("blue")
            cube(1, center = true);
translate([servo_spread, servo_pos, -(servo_height/2)])
    scale([servo_width, servo_length, servo_height])
        color("blue")
            cube(1, center = true);
translate([0, -support_wheel_pos, -(support_wheel_height/2)])
    scale([support_wheel_width, support_wheel_thickness, support_wheel_height])
        color("white")
            cube(1, center = true);
