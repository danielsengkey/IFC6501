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

package ifc6501.sim01;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.physicallayer.contract.packetlevel.IRadioMedium;
import inet.visualizer.integrated.IntegratedCanvasVisualizer;
import inet.common.figures.DelegateSignalConfigurator;

network Association
{
    parameters:
        string mediumType;
       
        @figure[title](type=label; pos=0,-1; anchor=sw; color=darkblue);
        @figure[sentPkText](type=indicatorText; pos=240,50; anchor=w; font=,10; textFormat="packets sent: %g"; initialValue=0);
        @figure[rcvdPkText](type=indicatorText; pos=240,30; anchor=w; font=,10; textFormat="packets received: %g"; initialValue=0);
        	
        @statistic[rcvdPk](source=srv_rcvdPk; record=figure(count); targetFigure=rcvdPkText);
        @signal[srv_rcvdPk];
        @delegatesignal[rcvdPk](source=srv.udpApp[0].rcvdPk; target=srv_rcvdPk);
  
        @statistic[sentPk](source=cli_sentPk; record=figure(count); targetFigure=sentPkText);
        @signal[cli_sentPk];
        @delegatesignal[sentPk](source=cli[0].udpApp[0].sentPk; target=cli_sentPk);      
  
        @display("bgb=350,250;bgg=20,1,grey95");
    
    submodules:
        ap: AccessPoint {
            @display("p=50,100;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }
        srv: StandardHost {
            @display("p=50,170;i=device/server");
        }
        
        cli: WirelessHost {
            @display("p=250,100;r=,,#707070");
            @statistic[state](title="contention state"; source=stateChanged; record=vector; interpolationmode=none; enum="IDLE=0, DEFER=1, IFS_AND_BACKOFF=2, OWNING=3");
            @statistic[radioMode](title="Radio mode"; source=radioModeChanged; record=count,vector; interpolationmode=sample-hold; enum="OFF=0, SLEEP=1, RECEIVER=2, TRANSMITTER=3, TRANSCEIVER=4, SWITCHING=5");
            @statistic[receptionState](title="Radio reception state"; source=receptionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, BUSY=2, RECEIVING=3");
            @statistic[transmissionState](title="Radio transmission state"; source=transmissionStateChanged; record=count,vector; interpolationmode=sample-hold; enum="UNDEFINED=0, IDLE=1, TRANSMITTING=2");
        }

        radioMedium: <mediumType> like IRadioMedium {
            @display("p=20,30");
        }
        configurator: IPv4NetworkConfigurator {
            @display("p=100,30");
        }
        visualizer: IntegratedCanvasVisualizer {
            @display("p=150,30");
        }
		figureHelper: DelegateSignalConfigurator{
		    @display("p=200, 30");
		}
    connections:
        ap.ethg++ <--> Eth100M <--> srv.ethg++;
}
