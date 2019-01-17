use GTK::Application;
use GTK::Raw::Types;
use GTK::Compat::Types;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::FlowBox;
use GTK::FlowBoxChild;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
);

$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }

  my GTK::Button $exit .= new_with_label: <exit>;
  $exit.clicked.tap: { $app.exit  };

  my GTK::Label $a .= new: <a>;
  my GTK::Label $b .= new: <b>;
  my GTK::Label $c .= new: <c>;
  my GTK::Label $d .= new: <d>;
  my GTK::Label $e .= new: <e>;
  my GTK::Label $f .= new: <f>;

  my @fbc;
  my @labels = ($a, $b, $c, $d, $e, $f);

  my GTK::FlowBox $flowbox .= new;
  $flowbox.min_children_per_line = 3;
  $flowbox.max_children_per_line = 3;
  $flowbox.halign = GTK_ALIGN_START;
  $flowbox.valign = GTK_ALIGN_START;
  $flowbox.row-spacing = 7;
  $flowbox.column-spacing = 7;
  $flowbox.homogeneous = True;
  $flowbox.selection-mode = GTK_SELECTION_MULTIPLE;
  
  $flowbox.key-press-event.tap( -> *@a {
  my $cmd = cast(GdkEventKey, @a[1]).string;

  given $cmd {
    @a[*-1].r = cmd(<s>) when <s>;
    @a[*-1].r = cmd(<c>) when <c>;

    default { @a[*-1].r = True };
  }
  
  multi cmd ('s') {
    $flowbox.remove-all;
    @fbc = (@fbc[3..5], @fbc[0..2]).flat;
    for @fbc {
      .upref;
      $flowbox.add: $_;
    }
    $flowbox.show-all();
    
    return 1;        # GDK_EVENT_STOP;
  }

  # should work similiar to vim 'r' command, replace a charachter.
  multi cmd ('c') {
    $flowbox.get-selected-children.map({ .get-child.label = next-pressed-key() });
    
    # How to get the next pressed key
    sub next-pressed-key() { 'z' };
    return 0;        #GDK_EVENT_PROPAGATE;

  }
});

  for @labels -> $btn {
    @fbc.push: (my $fbc = GTK::FlowBoxChild.new);
    $fbc.add($btn);
    $fbc.upref;
    $flowbox.add: $fbc;
  }

  my $box = GTK::Box.new-vbox();
  $box.pack_start($flowbox, False, False, 0);
  $box.pack_start($exit, False, False, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;


