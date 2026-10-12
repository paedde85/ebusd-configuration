import "@ebusd/ebus-typespec";
import "./_templates.tsp";
import "../opdata_inc.tsp";
using Ebus;
using Ebus.Num;
using Ebus.Dtm;
using Ebus.Str;

namespace kromschroeder;

@zz(0x08) // needed here for write to source address calculation
namespace hc {

}

