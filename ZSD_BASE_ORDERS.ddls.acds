//table function 
@VDM.viewType: #BASIC
@EndUserText.label: 'BASE ORDERS'
define table function ZSD_BASE_ORDERS
returns {
   mandt            :mandt;
   vbeln            :vbeln;
   kunnr            :kunnr;
   posnr            :posnr;
   matnr            :matnr;
   werks            :werks_d;
   system_date      :abap.dats;
   waerk            :waerk;
   netwr            :netwr;
   erdat            :erdat;
   line_item_price  :netwr;
}
implemented by method zcl_open_amdp=>fetch_data;
