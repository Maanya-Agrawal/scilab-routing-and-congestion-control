clc;
clear;
close;

// Node sizes from 5 to 100
nodeCounts = 5:5:100;

bellmanFordTimes = zeros(1, length(nodeCounts));
dijkstraTimes = zeros(1, length(nodeCounts));

// Network parameters
networkAreaSize = 1000;
connectionRadius = 300;

for index = 1:length(nodeCounts)

    numberOfNodes = nodeCounts(index);

    // Generate network topology
    networkGraph = NL_T_LocalityConnex(numberOfNodes, networkAreaSize, connectionRadius);

    // Select random source node
    sourceNode = NL_F_RandInt1n(length(networkGraph.node_x));

    // Show graph only for largest network
    if numberOfNodes == 100 then
        scf();
        NL_G_ShowGraphN(networkGraph, 1);
        title("Network with 100 Nodes");
    end

    // Bellman-Ford timing
    totalTimeBellman = 0;
    for iteration = 1:5
        timer();
        [distanceVector, predecessorVector] = NL_R_BellmanFord(networkGraph, sourceNode);
        totalTimeBellman = totalTimeBellman + timer();
    end
    bellmanFordTimes(index) = totalTimeBellman / 5;

    // Dijkstra timing
    totalTimeDijkstra = 0;
    for iteration = 1:5
        timer();
        [distanceVector, predecessorVector] = NL_R_Dijkstra(networkGraph, sourceNode);
        totalTimeDijkstra = totalTimeDijkstra + timer();
    end
    dijkstraTimes(index) = totalTimeDijkstra / 5;

    disp("Number of Nodes: " + string(numberOfNodes));
    disp("Bellman-Ford Time: " + string(bellmanFordTimes(index)));
    disp("Dijkstra Time: " + string(dijkstraTimes(index)));

end

// Plot comparison
scf();
plot(nodeCounts, bellmanFordTimes, '-or');
plot(nodeCounts, dijkstraTimes, '-*b');

legend("Bellman-Ford", "Dijkstra");
xlabel("Number of Nodes");
ylabel("Execution Time (seconds)");
title("Routing Algorithm Performance Comparison");
