@AbapCatalog.sqlViewName: 'ZSD_OPEN_ORDER1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'composite sales view'
@VDM.viewType: #COMPOSITE
define view Zsd_Open_Orders_Compos
  with parameters
    p_erdat : erdat
  as select from    ZSD_BASE_ORDERS
    left outer to one join      marc as m   on  ZSD_BASE_ORDERS.matnr = m.matnr
                                and ZSD_BASE_ORDERS.werks = m.werks
    inner join      makt as mak on  ZSD_BASE_ORDERS.matnr = mak.matnr
                                and mak.spras             = 'E'
    left outer to one join vbakuk      on ZSD_BASE_ORDERS.vbeln = vbakuk.vbeln
                                and vbakuk.erdat = :p_erdat
  association [1..*] to vbpa as _vbpa on  _vbpa.vbeln = ZSD_BASE_ORDERS.vbeln
                                      and _vbpa.parvw = 'AG'
  association [1..*] to vbep as _vbep on  _vbep.vbeln = ZSD_BASE_ORDERS.vbeln
                                      and _vbep.posnr = ZSD_BASE_ORDERS.posnr
  association [1..1] to kna1 as _kna1 on  _kna1.kunnr = ZSD_BASE_ORDERS.kunnr
  association [1..*] to adrc as _adrc on  _adrc.addrnumber = _vbpa.adrnr
{
  key ZSD_BASE_ORDERS.vbeln                                 as SalesOrd,
  key posnr                                                 as SalesItm,
      ZSD_BASE_ORDERS.kunnr                                 as NormCust, //normal customer
      _kna1.name1                                           as SoldtoName1,
      _kna1.name2                                           as SoltoName2,
      _kna1.land1                                           as SoldtoCntry,
      _kna1.ort01                                           as SoldtoOrt,
      _vbpa.kunnr                                           as sold_to,
      _vbpa.adrnr                                           as SoldtoAdrnr,
      _vbpa.parvw                                           as SoldtoFunc,
      _vbep.etenr                                           as ScheduleLine,
      _vbep.ettyp                                           as SchedulType,
      _vbep.vrkme                                           as SDvrkme,
      _vbep.bsart                                           as OrdType,
      _vbep.wadat                                           as GoodsIssuedate,
      ZSD_BASE_ORDERS.erdat,
      dats_days_between(ZSD_BASE_ORDERS.erdat, _vbep.edatu) as days_deliver,
      dats_days_between(system_date, _vbep.edatu )          as days_remaining,
      ZSD_BASE_ORDERS.matnr,
      mak.maktx,
     m.werks,
      m.dispo,
      case when vbakuk.gbstk = 'C' then 'CLOSED ORDER'
      else 'OPEN ORDER' end                                 as order_status,
      ZSD_BASE_ORDERS.waerk,
      @Semantics.amount.currencyCode: 'WAERK'
      ZSD_BASE_ORDERS.netwr,
      @Semantics.amount.currencyCode: 'WAERK'
      ZSD_BASE_ORDERS.line_item_price,
      ( ZSD_BASE_ORDERS.netwr - line_item_price )           as differ,
      _vbep,
      _vbpa,
      _kna1,
      _adrc
}
where
      ZSD_BASE_ORDERS.erdat = :p_erdat
  and ZSD_BASE_ORDERS.mandt = $session.client
