//
// Copyright (C) 2005 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//

package ifc6501.sim02;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth1G;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.common.figures.DelegateSignalConfigurator;

network HandoverNetwork
{
    parameters:
        @display("bgb=1000,600;bgl=2");
        int hostNumber = default(1);
        
    submodules:
        srv: StandardHost {
            @display("p=500,500;i=device/server");
        }
        host[hostNumber]: WirelessHost {
            @display("p=50,125;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        ap1: AccessPoint {
            @display("p=100,200;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");

        }
        ap2: AccessPoint {
            @display("p=500,200;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        ap3: AccessPoint {
            @display("p=900,200;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=25.099998,27.609999");
        }
        configurator: IPv4NetworkConfigurator {
            parameters:
                assignDisjunctSubnetAddresses = false;
                @display("p=140.56,27.609999");
        }
        etherSwitch: EtherSwitch {
            @display("p=500,400");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=395.32498,27.609999");
        }
        figureHelper: DelegateSignalConfigurator {
            @display("p=273.59,27.609999");
        }
    connections:
        ap1.ethg++ <--> Eth1G <--> etherSwitch.ethg++;
        etherSwitch.ethg++ <--> Eth1G <--> ap2.ethg++;
        etherSwitch.ethg++ <--> Eth1G <--> srv.ethg++;
        ap3.ethg++ <--> Eth1G <--> etherSwitch.ethg++;
}

