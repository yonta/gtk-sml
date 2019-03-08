local
val GTK_WINDOW_TOPLEVEL = 0
val GTK_WINDOW_POPUP = 1
type GtkWidget = unit
type GtkContainer = unit
val cMalloc = _import "malloc" : int -> unit ptr;
val cFree = _import "free" : unit ptr -> ();
fun mapi f xs =
    let
      fun go _ [] = []
        | go i (x::xs) = f(i,x)::go (i+1) xs
    in
      go 0 xs
    end
fun toCString (str : string) : char ptr =
    let
      val len = size str;
      val cstr : char ptr =
          SMLSharp_Builtin.Pointer.fromUnitPtr (cMalloc (len + 1))
    in
      mapi
        (fn (i,c) => Pointer.store (Pointer.advance(cstr, i), c)) (explode str);
      Pointer.store (Pointer.advance(cstr, len), chr 0);
      cstr
    end
fun toCPtrArray (arr: 'a ptr array) : 'a ptr ptr =
    let
      val ptr : 'a ptr ptr =
          SMLSharp_Builtin.Pointer.fromUnitPtr (cMalloc (Array.length arr))
    in
      Array.appi (fn (i,x) => Pointer.store (Pointer.advance(ptr, i), x)) arr;
      ptr
    end
val cGtkInit = _import "gtk_init" : (int ref, char ptr ptr ref) -> ()
(*
 * eldeshさんが力技した
 * https://gist.github.com/eldesh/e6fff4c522fff8d2a92be7ae5735f18f
 *)
fun gtkInit args =
    let
      val argc = length args
      val args_array = Array.fromList (map toCString args)
      val args = toCPtrArray args_array
    in
      cGtkInit (ref argc, ref args);
      Array.app (cFree o SMLSharp_Builtin.Pointer.toUnitPtr) args_array;
      cFree (SMLSharp_Builtin.Pointer.toUnitPtr args)
    end
val gtkWindowNew = _import "gtk_window_new" : int -> GtkWidget ptr
val gtkWidgetSetSizeRequest =
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

in (* local *)

val () = gtkInit (CommandLine.name () :: CommandLine.arguments ())
val window = gtkWindowNew (GTK_WINDOW_TOPLEVEL)
val () = gtkWidgetSetSizeRequest (window, 300, 200)
val button = gtkButtonNewWithLabel ("Quit")
val () = gtkContainerAdd (GTK_CONTAINER (window), button)
val () = gtkWidgetShowAll (window)
val () = gtkMain ()

end (* local *)
