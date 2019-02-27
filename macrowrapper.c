#include <gtk/gtk.h>

GtkContainer *gtk_container_cast(GtkWidget* window)
{
  return GTK_CONTAINER(window);
}
