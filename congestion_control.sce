clc;
clear;
close;
clf();

networkSizes = [200 300];
executionTimes = zeros(1, length(networkSizes));

networkAreaSize = 1500;
connectionRadius = 350;

for index = 1:length(networkSizes)

    numberOfNodes = networkSizes(index);

    networkGraph = NL_T_LocalityConnex(numberOfNodes, networkAreaSize, connectionRadius);

    // Show network in separate window
    NL_G_ShowGraphN(networkGraph, index);
    xtitle("Network with " + string(numberOfNodes) + " Nodes");

    // Congestion simulation
    timer();
    loadVector = rand(1, numberOfNodes) * 100;
    congestionLevel = sum(loadVector) / numberOfNodes;
    executionTime = timer();

    executionTimes(index) = executionTime;

    disp("Nodes: " + string(numberOfNodes));
    disp("Congestion Level: " + string(congestionLevel));
    disp("Execution Time: " + string(executionTime));

end

// Performance graph
scf(3);
plot(networkSizes, executionTimes, '-or');

xlabel("Number of Nodes");
ylabel("Execution Time (seconds)");
xtitle("Congestion Control Performance");
