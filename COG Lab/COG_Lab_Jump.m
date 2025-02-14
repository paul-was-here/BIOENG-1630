% COG Lab
% Paul Kullmann, Pierce Shipp, Veda Panchagnula, Sarah Bauman

% Important: data is read directly from the .xlsx files. Make sure they are
% in the same folder as the script.

weight = 88.8; % (kg)
height = 2010; % (mm)

% Location data (mm)
data = readmatrix('TuesJump.xlsx');
centersofgravity = zeros(1,length(data)-1); % yeah i ran out of variable names

z_head = data(2:length(data),3);
z_c7 = data(2:length(data),4);
z_lsho = data(2:length(data),5);
z_lelb = data(2:length(data),6);
z_lwr = data(2:length(data),7);
z_lfin = data(2:length(data),8);
z_rsho = data(2:length(data),9);
z_relb = data(2:length(data),10);
z_rwr = data(2:length(data),11);
z_rfin = data(2:length(data),12);
z_lhip = data(2:length(data),13);
z_lkne = data(2:length(data),14);
z_lhee = data(2:length(data),15);
z_lank = data(2:length(data),16);
z_ltoe = data(2:length(data),17);
z_rhip = data(2:length(data),18);
z_rkne = data(2:length(data),19);
z_rhee = data(2:length(data),20);
z_rank = data(2:length(data),21);
z_rtoe = data(2:length(data),22);

for i = 1:length(centersofgravity)
    % Trunk
    trunk_cog = z_lhip(i) + 0.483*(z_c7(i) - z_lhip(i));
    trunk_wt = 0.496 * weight;
    
    % Head and Neck
    head_cog = z_c7(i) + 0.433*(z_head(i) - z_c7(i));
    head_wt = 0.079 * weight;
    
    % Right Thigh
    rthigh_cog = z_rkne(i) + 0.567*(z_rhip(i) - z_rkne(i));
    rthigh_wt = 0.097 * weight;
    
    % Right Snank
    rshank_cog = z_rank(i) + 0.567*(z_rkne(i) - z_rank(i));
    rshank_wt = 0.045 * weight;
    
    % Right Foot
    rfoot_cog = z_rhee(i) + 0.5*(z_rank(i) - z_rhee(i));
    rfoot_wt = 0.014 * weight;
    
    % Left Thigh
    lthigh_cog = z_lkne(i) + 0.567*(z_lhip(i)-z_lkne(i));
    lthigh_wt = 0.097 * weight;
    
    % Left Shank
    lshank_cog = z_lank(i) + 0.567*(z_lkne(i)-z_lank(i));
    lshank_wt = 0.045 * weight;
    
    % Left Foot
    lfoot_cog = z_lhee(i) + 0.5*(z_lank(i) - z_lhee(i));
    lfoot_wt = 0.014 * weight;
    
    % Right Arm
    rarm_cog = z_relb(i) + 0.564*(z_rsho(i) - z_relb(i));
    rarm_wt = 0.035 * weight;
    
    % Right Forearm
    rfarm_cog = z_rwr(i) + 0.57*(z_relb(i) - z_rwr(i));
    rfarm_wt = 0.015 * weight;
    
    % Right Hand
    rhand_cog = z_rfin(i) + 0.564*(z_rwr(i) - z_rfin(i));
    rhand_wt = 0.006 * weight;
    
    % Left Arm
    larm_cog = z_lelb(i) + 0.564*(z_lsho(i) - z_lelb(i));
    larm_wt = 0.035 * weight;
    
    % Left Forearm
    lfarm_cog = z_lwr(i) + 0.57*(z_lelb(i) - z_lwr(i));
    lfarm_wt = 0.015 * weight;
    
    % Left Hand
    lhand_cog = z_lfin(i) + 0.564*(z_lwr(i) - z_lfin(i));
    lhand_wt = 0.006 * weight;
    
    weights = whos('-regexp', '_wt');
    cogs = whos('-regexp', '_cog');
    
    % This loop determines the numerator of the COG equation
    wtsum = 0;
    for j = 1:length(weights)
        wtsum = wtsum + eval(weights(j).name);
    end
    
    % This loop is for the denominator
    cogsum = 0;
    for j = 1:length(weights)
        cogsum = cogsum + eval(weights(j).name)*eval(cogs(j).name);
        % variables with _wt and _cog appended correspond alphabetically, so
        % this works
    end
    
    cog_overall = cogsum/wtsum/10; %mm to cm
    centersofgravity(i) = cog_overall;
end

plot(centersofgravity);
title("Jump")
xlabel("Frame")
ylabel("COG (cm)")