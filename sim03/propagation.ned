//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package ifc6501.sim03;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.AdhocHost;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;


network Propagation
{
    parameters:
        int n; //number of clients
        @display("bgb=1000,1000");
    submodules:
        srv: AdhocHost {
            @display("p=500,500;i=device/server;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
			@statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
        	@statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
        	@statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        cli[n]: AdhocHost {
            @display("i=device/wifilaptop;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
			@statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
        	@statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
        	@statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=58,25");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=162,30");
        }
}
