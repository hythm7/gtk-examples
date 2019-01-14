use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Grid;

class G { 
  also is GTK::Grid;
  
  method new () {
    say 1;
    my $o = nextsame;
    #say 2;
    #self.bless(grid => $o);
  }
  
  submethod BUILD() {
    self.attach: GTK::Button.new_with_label('aaa'), 0, 0, 1, 1;
  }
}

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  
  my GTK::Button $exit .= new_with_label: <exit>;
  $exit.clicked.tap: { $app.exit  };
  my G $grid .= new;
  
  my $box = GTK::Box.new-vbox(4);

  $box.pack_start($grid, False, True, 0);
  $box.pack_start($exit, False, True, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;
