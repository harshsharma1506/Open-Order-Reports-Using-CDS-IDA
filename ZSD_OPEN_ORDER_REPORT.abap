*&---------------------------------------------------------------------*
*& Report ZB_TEST
*&---------------------------------------------------------------------*
*& Author - Harsh Sharma
*&---------------------------------------------------------------------*
REPORT zsd_open_order_report.
*--> All includes 
INCLUDE: zsd_open_order_data,
         zsd_open_order_sel,
         zsd_open_order_cls.

START-OF-SELECTION.
*--> Object of the local class
DATA(lo_caller) = NEW lcl_ida_alv( ).
lo_caller->call_ida( ).
