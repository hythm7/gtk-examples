use GTK::Application;
use GTK::Compat::Types;
use GTK::Box;
use GTK::Button;
use GTK::Grid;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);


$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  
  my GTK::Button $exit .= new_with_label: <exit>;
  
  my GTK::Button $a .= new_with_label: <a>;
  my GTK::Button $b .= new_with_label: <b>;
  my GTK::Button $c .= new_with_label: <c>;
  my GTK::Button $d .= new_with_label: <d>;
  my GTK::Button $e .= new_with_label: <e>;
  my GTK::Button $f .= new_with_label: <f>;
 
  $app.window.add-events: GDK_ALL_EVENTS_MASK;

  # Will be adding more event handling...
  $app.window.event.tap( -> ($win, $event, $data, $value) {
    given $event {
      event(cast(GdkEventKey,    $event)) when $event.type ~~ GDK_KEY_PRESS;
      event(cast(GdkEventButton, $event)) when $event.type ~~ GDK_BUTTON_PRESS;
    }
    $value.r = 0;
  }); 

  $exit.clicked.tap: { $app.exit  };

  my GTK::Grid $grid .= new;
  $grid.attach: $a, 0, 0, 1, 1;
  $grid.attach: $b, 1, 0, 1, 1;
  $grid.attach: $c, 2, 0, 1, 1;
  $grid.attach: $d, 0, 1, 1, 1;
  $grid.attach: $e, 1, 1, 1, 1;
  $grid.attach: $f, 2, 1, 1, 1;

  my $box = GTK::Box.new-vbox();

  $box.pack_start($grid, False, True, 0);
  $box.pack_start($exit, False, True, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;

multi event (GdkEventKey $event) {
  say $event.string;
}

multi event (GdkEventButton $event) {
  say $event.button;
}

