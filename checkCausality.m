%Function to check causality
function c = checkCausality(n,mag,system,x)
    %n timescale
    %x is input signal
    %% Initial values
    figure('Name',"CheckCausality: Signal at t=1 vs Signals at t>=1",'NumberTitle','on');
    subplotPos = 1;%we've made no plots so start at 1
    
    %% set t=1 as the time we want to monitor and see how it changes with future inputs
    xone = n(1)* -1 + 2;%find which index of x is t=1
    x(xone) = mag;%make an impulse at t=1 with the magnitude
    y = system(n,x);%calculate output matrix with input x
    
    subplot(2,2,subplotPos),stem(n,x),title("Input");%The input function with impulse at t=1
    subplotPos = subplotPos +1;
    subplot(2,2,subplotPos),stem(n,y),title("Output");%what the function looks like with a single impulse at t=1
    subplotPos = subplotPos +1;
    
    %% Create new matrix with future inputs and plot discretely
    x1(1,xone:length(n)) = mag;%initialize second input matrix with only future inputs
    y1 = system(n,x1);%Find output matrix with input x1
    subplot(2,2,subplotPos),stem(n,x1),title("Input");
    subplotPos = subplotPos +1;
    subplot(2,2,subplotPos),stem(n,y1),title("Output");
    
    %% Logically check if the future inputs changed the present output(t=1)
    if round(y(xone),4) ~= round(y1(xone),4)%If the output at t=1 somehow changed because of a future input
        %y is the ouput from an impulse at t=1
        %y1 is the ouput from a constant input at all times in the future
        disp("This system is non-causal")
    else
        disp("This system is causal")
    end
end
