clc;
clear;
close;
clf();

// Node sizes
nodeSizes = [500 400 300 200 100];

// Store execution times
executionTimes = zeros(1, length(nodeSizes));

// Network parameters
networkAreaSize = 2000;
connectionRadius = 400;

for index = 1:length(nodeSizes)

    numberOfNodes = nodeSizes(index);

    // Generate network
    networkGraph = NL_T_LocalityConnex(numberOfNodes, networkAreaSize, connectionRadius);

    // Show only 500 node network
    if numberOfNodes == 500 then
        NL_G_ShowGraphN(networkGraph, 1);
        xtitle("Network with 500 Nodes");
    end

    // Simulated congestion mapping
    timer();

    loadVector = rand(1, numberOfNodes) * 100;
    congestionLevel = sum(loadVector) / numberOfNodes;

    executionTime = timer();
    executionTimes(index) = executionTime;

    disp("Nodes: " + string(numberOfNodes));
    disp("Execution Time: " + string(executionTime));

end

// Performance graph
scf(2);
plot(nodeSizes, executionTimes, '-*b');

xlabel("Number of Nodes");
ylabel("Execution Time (seconds)");
xtitle("Congestion Mapping Performance");
