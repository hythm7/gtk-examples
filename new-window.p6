use GTK::Application;
use GTK::Window;
use GTK::Box;
use GTK::Button;
use GTK::Raw::Types;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);



$app.activate.tap({
  CATCH { default { .message.say; $app.exit } }
  my $box = GTK::Box.new-vbox(6);
  my GTK::Button $new-win .= new_with_label: <new-win>;

  $new-win.clicked.tap: { new-win };
  $box.pack_start($new-win, False, True, 0);

  $app.window.add: $box;
  $app.show_all;
});

$app.run;

sub new-win () {
	my GTK::Window $window .= new: GTK_WINDOW_TOPLEVEL, :title<NewWin>;
  $window.decorated = True;
  $window.border-width = 2;
	$app.add_window: $window;
  $window.show;
}
