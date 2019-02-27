val GTK_WINDOW_TOPLEVEL = 0
val GTK_WINDOW_POPUP = 1
type GtkWidget = unit
type GtkContainer = unit
(* string arrayが使えないので終わった *)
(* val gtkInit = _import "gtk_init" : (int ref, string array ref) -> () *)
val gtkWindowNew = _import "gtk_window_new" : int -> GtkWidget ptr
val gtkWidgetSetSize =
    _import "gtk_widget_set_size_request" : (GtkWidget ptr, int, int) -> ()
val gtkButtonNewWithLabel =
    _import "gtk_button_new_with_label" : string -> GtkWidget ptr
val GTK_CONTAINER =
    _import "gtk_container_cast" : GtkWidget ptr -> GtkContainer ptr
val gtkContainerAdd =
    _import "gtk_container_add" : (GtkContainer ptr, GtkWidget ptr) -> ()
val gtkWidgetShowAll =
    _import "gtk_widget_show_all" : GtkWidget ptr -> ()
val gtkMain = _import "gtk_main" : () -> ()

val args = Vector.fromList (CommandLine.arguments())
val argc = ref (Vector.length args);
(* val () = gtkInit(argc, args) *)
