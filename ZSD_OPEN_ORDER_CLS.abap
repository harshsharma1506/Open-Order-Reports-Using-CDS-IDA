*&---------------------------------------------------------------------*
*& Include          ZSD_OPEN_ORDER_CLS
*&---------------------------------------------------------------------*

CLASS lcl_ida_alv DEFINITION.
  PUBLIC SECTION.
    METHODS: call_ida.         "all the IDA activity goes on here
ENDCLASS.

CLASS lcl_ida_alv IMPLEMENTATION.
  METHOD call_ida.
    DATA lt_range TYPE if_salv_service_types=>yt_named_ranges. "local range for select options
    MOVE-CORRESPONDING s_doc[] TO lt_range[].
    LOOP AT lt_range INTO DATA(ls_range).
      ls_range-name = 'SALESORD'.
      MODIFY lt_range FROM ls_range.
    ENDLOOP.
    cl_salv_gui_table_ida=>create_for_cds_view(                "main call for calling CDS view
      EXPORTING
        iv_cds_view_name      = 'ZSD_OPEN_ORDERS_CONSUM'
      RECEIVING
        ro_alv_gui_table_ida  = lo_alv
    ).
    ls_persistence_key-report_name = sy-repid.                "key as current program
    lo_alv->layout_persistence( )->set_persistence_options(   "set the option for layout
      EXPORTING
        is_persistence_key           = ls_persistence_key
    ).
    lo_alv->display_options( )->set_title( iv_title =  'Open Order Report With Running Sum And Difference' ).
    lo_alv->toolbar( )->enable_listbox_for_layouts(   ). "drop down for layouts
    lo_alv->set_view_parameters( it_parameters = VALUE #( ( name = 'P_ERDAT' value = p_erdat ) ) ). " our CDS is parameter enabled hence
    lo_alv->set_select_options(
      EXPORTING
        it_ranges    = lt_range        "sales documents
    ).
    lo_alv->fullscreen( )->display( ). "display finally
  ENDMETHOD.
ENDCLASS.
