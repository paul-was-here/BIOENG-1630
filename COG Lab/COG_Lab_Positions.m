% COG Lab
% Paul Kullmann, Pierce Shipp, Veda Panchagnula, Sarah Bauman

% Important: data is read directly from the .xlsx files. Make sure they are
% in the same folder as the script.

weight = 88.8; % (kg)
height = 2010; % (mm)

% Location data (mm)
[z_head, z_c7, z_lsho, z_lelb, z_lwr, z_lfin, z_rsho, z_relb, z_rwr, z_rfin, z_lhip, z_lkne, z_lhee, z_lank, z_ltoe, z_rhip, z_rkne, z_rhee, z_rank, z_rtoe] = readvars('Tues4.xlsx');

% Trunk
trunk_cog = z_lhip + 0.483*(z_c7 - z_lhip);
trunk_wt = 0.496 * weight;

% Head and Neck
head_cog = z_c7 + 0.433*(z_head - z_c7);
head_wt = 0.079 * weight;

% Right Thigh
rthigh_cog = z_rkne + 0.567*(z_rhip - z_rkne);
rthigh_wt = 0.097 * weight;

% Right Snank
rshank_cog = z_rank + 0.567*(z_rkne - z_rank);
rshank_wt = 0.045 * weight;

% Right Foot
rfoot_cog = z_rhee + 0.5*(z_rank - z_rhee);
rfoot_wt = 0.014 * weight;

% Left Thigh
lthigh_cog = z_lkne + 0.567*(z_lhip-z_lkne);
lthigh_wt = 0.097 * weight;

% Left Shank
lshank_cog = z_lank + 0.567*(z_lkne-z_lank);
lshank_wt = 0.045 * weight;

% Left Foot
lfoot_cog = z_lhee + 0.5*(z_lank - z_lhee);
lfoot_wt = 0.014 * weight;

% Right Arm
rarm_cog = z_relb + 0.564*(z_rsho - z_relb);
rarm_wt = 0.035 * weight;

% Right Forearm
rfarm_cog = z_rwr + 0.57*(z_relb - z_rwr);
rfarm_wt = 0.015 * weight;

% Right Hand
rhand_cog = z_rfin + 0.564*(z_rwr - z_rfin);
rhand_wt = 0.006 * weight;

% Left Arm
larm_cog = z_lelb + 0.564*(z_lsho - z_lelb);
larm_wt = 0.035 * weight;

% Left Forearm
lfarm_cog = z_lwr + 0.57*(z_lelb - z_lwr);
lfarm_wt = 0.015 * weight;

% Left Hand
lhand_cog = z_lfin + 0.564*(z_lwr - z_lfin);
lhand_wt = 0.006 * weight;

weights = whos('-regexp', '_wt');
cogs = whos('-regexp', '_cog');

% This loop determines the numerator of the COG equation
wtsum = 0;
for i = 1:length(weights)
    wtsum = wtsum + eval(weights(i).name);
end

% This loop is for the denominator
cogsum = 0;
for i = 1:length(weights)
    cogsum = cogsum + eval(weights(i).name)*eval(cogs(i).name);
    % variables with _wt and _cog appended correspond alphabetically, so
    % this works
end

cog_overall = cogsum/wtsum/10; %mm to cm
display(cog_overall)