clear;
clc;

sequence = 'CAAGTC';
x = 0;
y = 0;
x_coords = [x];
y_coords = [y];
for i = 1:length(sequence)
    switch sequence(i)
        case 'C'
            y = y + 1;
        case 'A'
            x = x + 1;
        case 'G'
            y = y - 1;
        case 'T'
            x = x - 1;
    end
    x_coords = [x_coords, x];
    y_coords = [y_coords, y];
end
plot(x_coords, y_coords, '-o');
title("Example walk for the genomic sequence 'CAAGTC'");
xlabel('X Coordinate');
ylabel('Y Coordinate');
x_range = [min(x_coords) - 0.25, max(x_coords) + 0.25]; % half unit margin for x-axis
y_range = [min(y_coords) - 0.25, max(y_coords) + 0.25]; % half unit margin for y-axis
axis([x_range y_range]);
axis equal;
savefig('figure1');
