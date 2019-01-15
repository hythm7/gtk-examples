use GTK::Raw::Types;
use GTK::Compat::Types;
use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Grid;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
);

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  
  my GTK::Button $exit .= new_with_label: <exit>;
  my GTK::Button $swap .= new_with_label: <swap>;

  $exit.clicked.tap: { $app.exit  };

  my GTK::Button $a .= new_with_label: <a>;
  my GTK::Button $b .= new_with_label: <b>;
  my GTK::Button $c .= new_with_label: <c>;
  my GTK::Button $d .= new_with_label: <d>;
  my GTK::Button $e .= new_with_label: <e>;
  my GTK::Button $f .= new_with_label: <f>;

  my @buttons;
  @buttons.push: $a, $b, $c, $d, $e, $f;
  @buttons.map({ .relief = GTK_RELIEF_NONE });


  my GTK::Grid $grid .= new;

  my $col0 = 0;
  my $col1 = 1;
  my $col2 = 2;
  
  my $row0 = 0;
  my $row1 = 1;
  
  $grid.attach($a, $col0, $row0, 1, 1);
  $grid.attach($b, $col1, $row0, 1, 1);
  $grid.attach($c, $col2, $row0, 1, 1);
  $grid.attach($d, $col0, $row1, 1, 1);
  $grid.attach($e, $col1, $row1, 1, 1);
  $grid.attach($f, $col2, $row1, 1, 1);
  
  $swap.clicked.tap: {
    ($row0, $row1) .= reverse;
    
    $grid.child-set-int($a, 'top_attach', $row0);
    $grid.child-set-int($b, 'top_attach', $row0);
    $grid.child-set-int($c, 'top_attach', $row0);
    $grid.child-set-int($d, 'top_attach', $row1);
    $grid.child-set-int($e, 'top_attach', $row1);
    $grid.child-set-int($f, 'top_attach', $row1);
  };



  my $box = GTK::Box.new-vbox(4);

  $box.pack_start($grid, False, False, 0);
  $box.pack_start($swap, False, False, 0);
  $box.pack_start($exit, False, False, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;
