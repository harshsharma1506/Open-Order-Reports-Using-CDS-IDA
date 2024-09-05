*&---------------------------------------------------------------------*
*& Include          ZSD_OPEN_ORDER_SEL
*&---------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_erdat TYPE erdat OBLIGATORY. "since CDS has param this is always mandatory
  SELECT-OPTIONS: s_doc FOR vbak-vbeln.      "sales orders
SELECTION-SCREEN END OF BLOCK b1.
