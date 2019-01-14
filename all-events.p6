use GTK::Application;
use GTK::Raw::Types;
use GTK::Compat::Types;
use GTK::Box;
use GTK::Button;
use GTK::Grid;

class GdkEventMotion is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has guint32        $.time;
  has gdouble        $.x;
  has gdouble        $.y;
  has gdouble        $.axes is rw;
  has guint          $.state;
  has gint16         $.is_hint;
  has GdkDevice      $.device;
  has gdouble        $.x_root;
  has gdouble        $.y_root;
}

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);


$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  
  my GTK::Button $exit .= new_with_label: <exit>;
  
  my GTK::Button $a .= new_with_label: <a>;
  my GTK::Button $m .= new_with_label: <m>;
  my GTK::Button $c .= new_with_label: <c>;
  my GTK::Button $w .= new_with_label: <w>;
  my GTK::Button $y .= new_with_label: <y>;
  my GTK::Button $z .= new_with_label: <z>;
  
  #$w.clicked.tap({ say .label});
 
  # $a.halign = GTK_ALIGN_FILL;
  #$a.valign = GTK_ALIGN_FILL;
  #$m.halign = GTK_ALIGN_FILL;
  #$m.valign = GTK_ALIGN_FILL;
  #$c.halign = GTK_ALIGN_FILL;
  #$c.valign = GTK_ALIGN_FILL;
  #$w.halign = GTK_ALIGN_FILL;
  #$w.valign = GTK_ALIGN_FILL;
  #$y.halign = GTK_ALIGN_FILL;
  #$y.valign = GTK_ALIGN_FILL;
  #$z.halign = GTK_ALIGN_FILL;
  #$z.valign = GTK_ALIGN_FILL;
  
  my GTK::Grid $grid .= new;
  $grid.add-events: GDK_KEY_PRESS_MASK +| GDK_BUTTON_PRESS_MASK;

  # Will be adding more event handling...
  $grid.event.tap( -> ($w, $event, $data, $value) {
    say $w;
    say $data.perl;
    say $value;
    given $event.type {
      event(GDK_KEY_PRESS,        cast(GdkEventKey,       $event).string) when GDK_KEY_PRESS;
      #event(GDK_KEY_RELEASE,      cast(GdkEventKey,       $event)) when GDK_KEY_RELEASE;
      event(GDK_BUTTON_PRESS,     cast(GdkEventButton,    $event)) when GDK_BUTTON_PRESS;
      #event(GDK_BUTTON_RELEASE,   cast(GdkEventButton,    $event)) when GDK_BUTTON_RELEASE;
      #event(GDK_2BUTTON_PRESS,    cast(GdkEventButton,    $event)) when GDK_2BUTTON_PRESS;
      #event(GDK_SELECTION_NOTIFY, cast(GdkEventSelection, $event)) when GDK_SELECTION_REQUEST;
      #event(GDK_SELECTION_NOTIFY, cast(GdkEventSelection, $event)) when GDK_SELECTION_NOTIFY;
      #event(GDK_SELECTION_NOTIFY, cast(GdkEventSelection, $event)) when GDK_SELECTION_CLEAR;
      #event(GDK_MOTION_NOTIFY,  cast(GdkEventMotion, $event)) when GDK_MOTION_NOTIFY;
    }
    $value.r = 0;
  }); 

  $exit.clicked.tap: { $app.exit  };

  $grid.halign = GTK_ALIGN_START;
  $grid.valign = GTK_ALIGN_START;
  $grid.row-homogeneous = True;
  $grid.column-homogeneous = True;

  $grid.attach: $a, 0, 0, 1, 1;
  $grid.attach: $m, 1, 0, 1, 1;
  $grid.attach: $c, 2, 0, 1, 1;
  $grid.attach: $w, 0, 1, 1, 1;
  $grid.attach: $y, 1, 1, 1, 1;
  $grid.attach: $z, 2, 1, 1, 1;

  my $box = GTK::Box.new-vbox();

  $box.pack_start($grid);
  $box.pack_start($exit);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;

multi event (GDK_KEY_PRESS, $key) {
  say $key;
}

multi event (GDK_KEY_RELEASE, GdkEventKey $event) {
  say $event.string;
}

multi event (GDK_BUTTON_PRESS, GdkEventButton $event) {
  say $event.button;
}

multi event (GDK_2BUTTON_PRESS, GdkEventButton $event) {
  say 2;
}

multi event (GDK_BUTTON_RELEASE, GdkEventButton $event) {
  say $event.button;
}

multi event (GDK_SELECTION_NOTIFY, GdkEventSelection $event) {
  say $event.selection;
}

multi event (GDK_MOTION_NOTIFY, GdkEventMotion $event) {
  say $event;
}

