function rr()
process_count = "Enter number of processes: ";
n = input(process_count);

input_quantum = Enter quantum time: ";
q = input(input_quantum);

btime = zeros(1,n);  %burst time		
wtime = zeros(1,n);  %waiting time

for i=1:1:n
    fprintf("Enter burst time of process P%d: ", i);
    tmp = input(" ");
    btime(i) = tmp;
    fprintf("Enter arrival time of process P%d: ", i);
    tmp = input(" ");
    wtime(i) = wtime(i) - tmp;
end

tatime = zeros(1,n);  %turn around time

rtime = btime;        %intially remaining time = burst time
b = 0;
t = 0;
flag = 1;             %this is set if process has burst time left after quantum time is completed
while(flag==1)        %loop until flag = 0
    flag = 0;
    for i=1:1:n
        if(rtime(i) >= q)
            fprintf('-> P%d ', i);
            for j=1:1:n
                if(j==i)
                    rtime(i) = rtime(i) - q;
                else if(rtime(j) > 0)
                        wtime(j) = wtime(j) + q;
                    end
                end
            end
        else if(rtime(i) > 0)
                fprintf('-> P%d ', i);
                for j=1:1:n
                    if(rtime(j) > 0 && j~=i)
                        wtime(j) = wtime(j) + rtime(i)                                         
                    end                                    
                end
                rtime(i) = 0;
            end
        end
    end
    for i=1:1:n
        if(rtime(i) > 0)
            flag = 1;
        end
    end
end
for i=1:1:n
    tatime(i) = wtime(i) + btime(i);    %calculating turn around time for each process by adding waiting time and burst time
end
fprintf('\nProcess    Burst time      Waiting time          Turn Around time\n'); %displaying the final values
for i=1:1:n
    fprintf('P%d\t\t%d\t\t%d\t\t\t%d\n', i, btime(i), wtime(i), tatime(i));
    b = b + wtime(i);
    t = t + tatime(i);
end
fprintf('Average waiting time: %f\n', (b/n));
fprintf('Average turn around time: %f\n', (t/n));
