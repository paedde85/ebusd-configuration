import "@ebusd/ebus-typespec";
import "./_templates.tsp";
import "../opdata_inc.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;

namespace kromschroeder;

@zz(0xf6) // needed here for write to source address calculation
namespace hc {
  /** Betriebsdaten des Reglers an den Feuerungsautomaten */
  @write(true)
  model Operation is Opdata_inc.HcOperation;

  /** default *b */
@passive 
@zz(BROADCAST)
model b {
}

/** Broadcast mit Istwerten */
@passive 
@id(0x50, 0xa)
model Act {
  Status1: Status,
  /** Betriebsphase */
  Operatingphase: opdataheat,
  Ukn2_1:     BI0,
  Ukn2_2:     BI1,
  Ukn2_3:     BI2,
  Flame:      BI3,
  GasValve1:  BI4,
  GasValve2:  BI5,
  Pump:       BI6,
  Error:      BI7,
  Ukn3_1:     BI0,
  @values(Values_SoWi)
  SoWi:       BI1,
  Ukn3_3:     BI2,
  Ukn3_4:     BI3,
  Ukn3_5:     BI4,
  Ukn3_6:     BI5, 
  Ukn3_7:     BI6,
  /** 0=Heating;1=DHW */   
  SettingUV:      BI7,
  /** Laststellung */
  Load:           UCH,
  /** Vorlauftemperatur */
  SupplyTemp:     temp1,
  /** Abgastemperatur */
  FlueGasTemp:    temp1,
  /** Warmwassertemperatur */
  DHWTemp:        temp1,
  /** Unbekannte Temperatur */
  UknTemp:        temp1,
  /** Außentemperatur */
  ExternalTemp:   outsidetemp,
  /** Temperaturtrend */
  TrendTemp:      temp2,
  /** Vorlauf Solltemperatur */
  SupplySetTemp:  temp0
}

enum Values_SoWi {
  Summer: 0,
  Winter: 1,
}

}

