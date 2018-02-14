%{
-----------------------------------------------------------
                 Bootstrap Hypothesis Testing
                        Sam Qian
-----------------------------------------------------------

Here, I work with fly larva behavioral data from two experimental
conditions (n=24 each) and ask whether their means are significantly
different using bootstrap hypothesis testing.

Bootstrap procedure: 
http://faculty.psy.ohio-state.edu/myung/personal/course/826/bootstrap_hypo.pdf

%}
clear all;
close all;
clc;

% Load data
load curvatureData.mat

% Graph data
boxplot(curvatureData,'labels',{'Control', 'Experimental'});
ylabel('Curvature Index');

% Calculate sample mean difference
dif = abs(mean(curvatureData(:,1)) - mean(curvatureData(:,2)));
disp(['Sample mean difference is ' num2str(dif, 4)]);

%%

% Null hypothesis: both samples are the from the same population. 
% Merge samples to draw observation from
merged = reshape(curvatureData,[48,1]);

% Simulate sampling from the merged observations B times
B = 3000;
for i=1:B
    x = datasample(merged,24); % sample w/ replacement
    y = datasample(merged,24); % sample w/ replacement
    Bdif(i) = abs(mean(x)-mean(y)); % calculate Boostrapped sample mean difference
end

% Visualize distribution of Bootstrapped test statistic (mean difference)
figure;
hold on;
hist(Bdif,50);
xlabel('Mean difference from Bootstrapped samples');
ylabel('Number of times');
a=[dif,dif];
b=[0,200];
plot(a,b,'--')
disp('Vertical dashed line indicates the mean difference observed in original data');

%%

% Number of times Bootstrapped samples produced a mean difference greater
% than the mean difference of the original data
high_Bdif = find(Bdif>dif);
m = size(high_Bdif,2);

% Probability of getting a mean difference as big as from the original data
% if samples are from the same population.
p = m/B;
disp(['p = ', num2str(p,5)]);

if p<0.05
    disp('Reject the null hypothesis that the two samples are from the same population');
end




