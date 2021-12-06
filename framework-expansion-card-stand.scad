$fn = 200;
wall_thickness = 1.5;
// depth = 32;
depth = 10;
// depth = 0;
height = 6.9;
width = 30;
padding = 1.01;

padded_width = padding * width;
padded_height = padding * height;

slots = 1;
base_depth = 8;

usb_c_plug_width = 8.25;
usb_c_plug_height = 2.4;
usb_c_plug_depth = 6.5;

module usb_c_plug () {
  hull () {
    cylinder (usb_c_plug_depth, usb_c_plug_height / 2, usb_c_plug_height / 2);
    translate([0, usb_c_plug_width, 0])
      cylinder (usb_c_plug_depth, usb_c_plug_height / 2, usb_c_plug_height / 2);
  }
}

module slot_base () {
  difference () {
    cube([padded_height + wall_thickness * 2, padded_width + wall_thickness * 2, base_depth]);
    translate([wall_thickness + (padded_height / 2), wall_thickness + (padded_width - usb_c_plug_width) / 2, base_depth - usb_c_plug_depth])
      usb_c_plug();
  }
}

module slot () {
  slot_base();
  translate([0, 0, base_depth])
    difference () {
      cube([padded_height + wall_thickness * 2, padded_width + wall_thickness * 2, depth]);
      translate([wall_thickness, wall_thickness])
        cube([padded_height, padded_width, depth]);
    };
}

slot();
