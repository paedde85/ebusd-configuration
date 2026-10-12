import "@ebusd/ebus-typespec";
import "../_templates.tsp";

using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;

namespace kromschroeder;
alias MF = 0x50; // Ebus.Id.Values_manufacturers.Kromschröder

/** temperature */
@unit("°C")
@divisor(10)
scalar temp10 extends UIN;

/** percent */
@unit("%")
scalar percent extends UIN;

/** minutes */
@unit("min")
scalar minutes extends UIN;

/** hours */
@unit("h")
scalar hours extends UIN;

@unit("U/sec")
scalar speed extends UIN;

/** Betriebsphase */
@values(Values_Operatingphase)
scalar operatingphase extends UCH;

/** default *r for register */
@base(MF, 0x22, 0x00) // todo 0x00 should rather be crc8 of following bytes, see https://github.com/john30/ebusd/issues/167
model regr {}

/** default *w for register */
@write(true)
@base(MF, 0x23, 0x00)
model regw {}

/** read/write register */
@inherit(regr, regw) //todo first byte of ext always 0x0 on write
model Register<T, suffixValue extends valueof string = "9d010000"> {
  value: T;

  @maxLength(4)
  @out(true)
  @constValue(suffixValue)
  suffix: HEX;
}

/** read only register */
@inherit(regr)
model ReadonlyRegister<T> {
  value: T;
}

enum Values_Operatingphase {
  BrennerAus: 0x00,
  RuhestandskontrolleGeblaese: 0x01,
  VorspuehldrehzahlErreichen: 0x02,
  CountdownVorspuehlzeit: 0x03,
  ZuenddrehzahlErreichen: 0x04,
  Flammenbildungszeit: 0x05,
  BrennerInBetrieb: 0x06,
  GasventilkontrolleV1: 0x07,
  GasventilkontrolleV2: 0x08,
  Nachspuehlen: 0x09,
  S_Kesseltemperatur_105_C: 0x0B,
  W_Kesseltemperatur_95_C: 0x0C,
  S_Abgastemperatur_120_C: 0x0D,
  W_Vorlauftemperatur_Gradient_zu_gro: 0x0E,
  W_S_Temperaturdifferenz_zu_gro: 0x0F,
  W_Abgastemperatur_115_C: 0x10,
  S_Keine_Flammbildung_beim_Brennerstart: 0x15,
  W_Flammausfall_waehrend_des_Betriebs: 0x16,
  S_Flammenvortaeuschung: 0x17,
  S_Fu_bodenthermostat_am_Eingang_H2_hat_angesprochen: 0x18,
}