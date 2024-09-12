@AbapCatalog.sqlViewName: 'ZSD_OPEN_ORDERS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'consumption cds'
@VDM.viewType: #CONSUMPTION
define view Zsd_Open_Orders_Consum
  with parameters
    p_erdat : erdat
  as select from Zsd_Open_Orders_Compos( p_erdat: $parameters.p_erdat)
{
      //Zsd_Open_Orders_Compos
      @EndUserText.label: 'Sales Order'
  key SalesOrd,
      @EndUserText.label: 'Sales Item'
  key SalesItm,
      @EndUserText.label: 'Customer Number General'
      NormCust,
      @EndUserText.label: 'Sold To Party'
      sold_to,
      @EndUserText.label: 'Soldto Name1'
      SoldtoName1,
      @EndUserText.label: 'Soldto Name2'
      SoltoName2,
      @EndUserText.label: 'Country'
      SoldtoCntry,
      @EndUserText.label: 'Region'
      SoldtoOrt,
      @EndUserText.label: 'Address Number'
      SoldtoAdrnr,
      @EndUserText.label: 'Schedule Lines'
      _adrc.post_code1,
      _adrc.street,
      ScheduleLine,
      @EndUserText.label: 'Type'
      SchedulType,
      @EndUserText.label: 'Sales Unit'
      SDvrkme,
      @EndUserText.label: 'Order Type'
      OrdType,
      @EndUserText.label: 'Issue Date'
      _vbpa.lifnr,
      GoodsIssuedate,
      @EndUserText.label: 'Created On'
      erdat,
      @EndUserText.label: 'Days Took To deliver'
      days_deliver,
      matnr,
      maktx,
      werks,
      dispo,
      @EndUserText.label: 'Order Status'
      order_status,
      waerk,
      netwr,
      @EndUserText.label: 'Line Item Running Sum'
      line_item_price,
      @EndUserText.label: 'Running Difference'
      differ,
      /* Associations */
      //Zsd_Open_Orders_Compos
      _vbep,
      _vbpa,
      _kna1,
      _adrc
}
