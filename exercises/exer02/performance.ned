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

package ifc6501.exercises.exer02;

import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.common.misc.ThruputMeteringChannel;
import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;

//
// A simple but realistic simulation model
// as starting point to understand simulation result processing
// @author Daniel Febrian Sengkey
//

network Performance
{
    parameters:
        int n = default(1); //number of clients
        
    submodules:
        server: StandardHost {
                @display("i=device/server");
        }
        client[n]: StandardHost;
        switch: EtherSwitch;
        configurator: IPv4NetworkConfigurator;
        
    connections:
        switch.ethg++ <--> ThruputMeteringChannel{ delay=normal(1ms,0.3ms); datarate = 100 Mbps; thruputDisplayFormat = "#b"; } <--> server.ethg++;
        for i=0..(n-1){
                client[i].ethg++ <--> ThruputMeteringChannel{ delay=normal(1ms,0.1ms); datarate = 10 Mbps; thruputDisplayFormat = "#b"; } <--> switch.ethg++;
        }
        
}
