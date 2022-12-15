$fn = 200;
wall_thickness = 1.5;

tight_fit = 0.1;
fit = 0.2;
loose_fit = 0.5;

// Depth of the sleeve
depth = 10; // [0: Base only, 10: Mini, 30: Full-size]

// Card height
height = 6.9;
// Card width
width = 30;

// For no base, set this to value smaller than USB-C plug depth:
base_depth = 7.5;

usb_c_plug_width = 8.25;
usb_c_plug_height = 2.4;
usb_c_plug_depth = 6.5;

// How many slots should the stand have.
slots = 1;

// Pick fits. If the tolerances are too tight for your printer/filament, here's
// where to start modifications.
height_fit = height + fit;
width_fit = width + fit;

usb_c_plug_width_fit = usb_c_plug_width + tight_fit;
usb_c_plug_height_fit = usb_c_plug_height + tight_fit;
// For printing on the Anycubic Vyper in PLA:
// usb_c_plug_width_fit = usb_c_plug_width + loose_fit;
// usb_c_plug_height_fit = usb_c_plug_height + loose_fit;

module usb_c_plug () {
  hull () {
    cylinder (usb_c_plug_depth, usb_c_plug_height_fit / 2, usb_c_plug_height_fit / 2); 
    translate([0, usb_c_plug_width_fit - usb_c_plug_height_fit, 0]) 
      cylinder (usb_c_plug_depth, usb_c_plug_height_fit / 2, usb_c_plug_height_fit / 2); 
  }
}

module slot_base () {
  difference () {
    cube([height + wall_thickness * 2, width + wall_thickness * 2, base_depth]);
    translate([wall_thickness + (height / 2), wall_thickness + ((width - usb_c_plug_width_fit + usb_c_plug_height_fit) / 2), base_depth - usb_c_plug_depth]) 
      usb_c_plug();
  }
}

module slot () {
  slot_base();
  translate([0, 0, base_depth])
    difference () {
      cube([height_fit + wall_thickness * 2, width_fit + wall_thickness * 2, depth]);
      translate([wall_thickness, wall_thickness])
        cube([height_fit, width_fit, depth]);
    };
}

for (i = [0 : slots - 1]) {
  translate([(height + wall_thickness) * i, 0, 0])
    slot();
}
