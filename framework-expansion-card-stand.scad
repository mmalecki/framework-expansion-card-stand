$fn = 500;
wall_thickness = 1.5;

// To render the base only:
// depth = 0;
// For full-size depth:
// depth = 32;
// Mini version:
depth = 10;
padding = 1.02;
height = 6.9 * padding;
width = 30 * padding;

// For no base, set this to value smaller than USB-C plug depth:
base_depth = 7.5;

plug_padding = 1.03;
usb_c_plug_width = 8.25 * plug_padding;
usb_c_plug_height = 2.4 * plug_padding;
usb_c_plug_depth = 6.5;

slots = 1;

module usb_c_plug () {
  hull () {
    cylinder (usb_c_plug_depth, usb_c_plug_height / 2, usb_c_plug_height / 2);
    translate([0, usb_c_plug_width - usb_c_plug_height, 0])
      cylinder (usb_c_plug_depth, usb_c_plug_height / 2, usb_c_plug_height / 2);
  }
}

module slot_base () {
  difference () {
    cube([height + wall_thickness * 2, width + wall_thickness * 2, base_depth]);
    translate([wall_thickness + (height / 2), wall_thickness + ((width - usb_c_plug_width + usb_c_plug_height) / 2), base_depth - usb_c_plug_depth])
      usb_c_plug();
  }
}

module slot () {
  slot_base();
  translate([0, 0, base_depth])
    difference () {
      cube([height + wall_thickness * 2, width + wall_thickness * 2, depth]);
      translate([wall_thickness, wall_thickness])
        cube([height, width, depth]);
    };
}

slot();
