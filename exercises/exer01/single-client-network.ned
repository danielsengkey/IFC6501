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

package ifc6501.exercises.exer01;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.ethernet.Eth100M;
import inet.node.inet.StandardHost;

//
// Simple network as simulation demo.
// @author Daniel Febrian Sengkey <danielfebrian015@gmail.com>
//

network single_client
{
    submodules:
        client: StandardHost;
        server: StandardHost {
            @display("i=device/server");
        }
        configurator: IPv4NetworkConfigurator;
    connections:
        client.ethg++ <--> Eth100M <--> server.ethg++;
}
