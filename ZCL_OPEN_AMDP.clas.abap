CLASS zcl_open_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    CLASS-METHODS: fetch_data FOR TABLE FUNCTION zsd_base_orders.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_open_amdp IMPLEMENTATION.

  METHOD fetch_data BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING vbak vbap.

    declare lv_client nvarchar( 3 ) := session_context( 'CLIENT' );
    declare lv_date_system varchar( 8 )     := session_context( 'SAP_SYSTEM_DATE' );

    lt_sales = SELECT a.mandt,
                      a.vbeln,
                      a.kunnr,
                      b.posnr,
                      b.matnr,
                      b.werks,
                      a.netwr,
                      b.netwr as line_item_price,
                      a.waerk,
                      a.erdat
                      from vbak as a inner join vbap as b
                      on a.vbeln = b.vbeln
                      where a.mandt = :lv_client
                      GROUP BY
                      a.mandt,
                      a.vbeln,
                      a.kunnr,
                      b.posnr,
                      b.matnr,
                      b.werks,
                      a.netwr,
                      b.netwr,
                      a.erdat,
                      a.waerk;

  lt_sales_final =  select mandt,
                           vbeln,
                           kunnr,
                           posnr,
                           matnr,
                           werks,
                           netwr,
                           waerk,
                           erdat,
                           SUM (line_item_price ) over( PARTITION by vbeln, werks ORDER BY posnr asc ) as line_item_price,
                           CASE WHEN erdat IS NOT NULL
                           THEN :lv_date_system
                           end as  system_date
                          FROM :lt_sales
                          WHERE mandt = :lv_client
                          group by
                          mandt,
                          vbeln,
                          posnr,
                          matnr,
                          kunnr,
                          werks,
                          netwr,
                          erdat,
                          line_item_price,
                          waerk;
   RETURN
   SELECT mandt,
          vbeln,
          kunnr,
          posnr,
          matnr,
          werks,
          system_date,
          waerk,
          netwr,
          erdat,
          line_item_price
          FROM :lt_sales_final
          where mandt = :lv_client;
  ENDMETHOD.
ENDCLASS.
