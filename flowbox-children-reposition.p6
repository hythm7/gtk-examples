use GTK::Application;
use GTK::Raw::Types;
use GTK::Compat::Types;
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

  my GTK::FlowBox $flowbox .= new;
  $flowbox.min_children_per_line = 3;
  $flowbox.max_children_per_line = 3;
  $flowbox.halign = GTK_ALIGN_START;
  $flowbox.valign = GTK_ALIGN_START;
  $flowbox.homogeneous = True;
  $flowbox.selection-mode = GTK_SELECTION_MULTIPLE;

  for @buttons -> $btn  is copy {
    my $child = GTK::FlowBoxChild.new();
    $child.add: $btn;
    $flowbox.add: $child;
  }
  
  $swap.clicked.tap: {
    #$flowbox.get-children.map(*.get-child.remove); # This does not remove the widgets
    $flowbox.remove-all();
    
    
    #  Below commented code works fine, but with warning 
    #  'GTK_IS_WIDGET (widget)' failed when removing the widget.
    #  for everytime swap button is clicked( after first time)
    #
    #my $child = GTK::FlowBoxChild.new();
    #my $button = GTK::Button.new_with_label: $++.Str;
    #$child.add: $button;
    #$flowbox.add: $child;
    
    for @buttons -> $newbtn is copy {
      my $child = GTK::FlowBoxChild.new();
      $child.add: $newbtn;
      $flowbox.add: $child;
    }
    
    $flowbox.show-all();
  }

  
  my $box = GTK::Box.new-vbox();

  $box.pack_start($flowbox, False, False, 0);
  $box.pack_start($swap, False, False, 0);
  $box.pack_start($exit, False, False, 0);
  
  $app.window.add: $box;
  $app.show_all;
});

$app.run;
