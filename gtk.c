#include <gtk/gtk.h>

int main(int argc, char** argv)
{
  gtk_init(&argc, &argv);

  GtkWidget *window;
  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_widget_set_size_request(window, 300, 200);

  GtkWidget *button;
  button = gtk_button_new_with_label("Quit");

  gtk_container_add(GTK_CONTAINER(window), button);

  gtk_widget_show_all(window);
  gtk_main();

  return 0;
}
