use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::FlowBox;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  
  my GTK::Button $exit .= new_with_label: <exit>;
  $exit.clicked.tap: { $app.exit  };

  my GTK::Button $a .= new_with_label: <a>;
  my GTK::Button $m .= new_with_label: <m>;
  my GTK::Button $c .= new_with_label: <c>;
  my GTK::Button $w .= new_with_label: <w>;
  my GTK::Button $y .= new_with_label: <y>;
  my GTK::Button $z .= new_with_label: <z>;


  my GTK::FlowBox $flowbox .= new;
  $flowbox.min_children_per_line = 2;
  $flowbox.max_children_per_line = 2;
  
  $flowbox.add: $a;
  $flowbox.add: $m;
  $flowbox.add: $c;
  $flowbox.add: $w;
  $flowbox.add: $y;
  $flowbox.add: $z;
  
  my $box = GTK::Box.new-vbox(4);

  $box.pack_start($flowbox, False, True, 0);
  $box.pack_start($exit, False, True, 0);
  
  $app.window.add: $box;
  $app.show_all;
});

$app.run;
