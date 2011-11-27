function test_ft_spike_plot_isireturn()

% TEST test_ft_spike_plot_isireturn

nTrials = 100;
data = [];
time       = linspace(0,1,1000);
data.trial(1:nTrials) = {zeros(1,length(time))};
data.time(1:nTrials) = {time};
for iTrial = 1:nTrials    
  for iUnit = 1:3
      data.trial{iTrial}(iUnit,:) = double(rand(1,1000)<0.05);
  end
end
data.fsample = 1000;
data.hdr = [];
data.cfg.trl = [];
data.label{1} = 'chan1';
data.label{end+1} = 'chan2';
data.label{end+1} = 'chan3';

% show that the psth works also with the poisson format
spike = ft_spike_data2spike([],data);
for iUnit  = 1:3
  spike.time{iUnit} =   spike.time{iUnit} + 0.001*rand(1,length(spike.time{iUnit}))'
end
%%
% now test the isi
cfgIsi = [];
cfgIsi.keeptrials = 'yes';
isih = ft_spike_isihist(cfgIsi,spike);
%%
figure
cfgIsi = [];
cfgIsi.spikechannel = 1;
cfgIsi.plotfit = 'yes'
cfgIsi.latency = [0 0.2];
h = ft_spike_plot_isi(cfgIsi,isih)
%%
cfgIsi = [];
cfgIsi.keeptrials = 'yes';
isih = ft_spike_isihist(cfgIsi,spike);
%%
cfgIsi = [];
cfgIsi.spikechannel = 1;
isihS = ft_spike_isihist(cfgIsi,spike);
%%
cfgIsi = [];
cfgIsi.spikechannel = 'all';
isihS = ft_spike_isihist(cfgIsi,spike);
%%
cfgRet = [];
cfgRet.kernel = 'mvgauss';
cfgRet.isimax = 0.2
cfgRet.interpolate = 'no';
cfgRet.scattersize = 1;
cfgRet.density = 'yes'
cfgRet.spikechannel = 1;
figure
H = ft_spike_plot_isireturn(cfgRet,isihS);
%%
figure
H = ft_spike_plot_isireturn([],isihS);
%%

