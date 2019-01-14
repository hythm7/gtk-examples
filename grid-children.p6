use GTK::Application;
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
  my GTK::Button $hello .= new_with_label: <hello>;
  my GTK::Button $world .= new_with_label: <world>;

  $exit.clicked.tap: { $app.exit  };

  my GTK::Grid $grid .= new;

  my $col0 = 0;
  my $col1 = 1;
  
  $grid.attach: $hello, $col0, 0, 1, 1;
  $grid.attach: $world, $col1, 0, 1, 1;
  
  say $grid.get-children();
  
  my $box = GTK::Box.new-vbox(4);

  $box.pack_start($exit, False, True, 0);


  $app.window.add: $box;
  $app.show_all;
});

$app.run;
