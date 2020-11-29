% This script generates the timecourse figures with 95% confidence
% intervals plotted on.
alpha = 0.05;
% Start by listing the ROIs to be used.
localBonf = 1; % Set to 1 to plot bonferroni corrected timecourses for sig 
               % +ve vals.  0 to plot the bonferroni accross the whole time
parDir= ''; % Parent directory, where the output folder should be found
roiDir = ''; % Directory where the ROIs are found
outDir = [parDir,'']; % Directory to put the final results
if ~exist(outDir,'dir')
    mkdir(outDir)
end
ROINames{1} = 'Supplementary_Motor_Area.mat';
ROINames{2} = 'Anterior_Insula_Frontal_Operculum.mat';
ROINames{3} = 'MSAD_sphere_7-0_-23_-7.mat';
ROINames{4} = 'ITL_ROI_indices';
ROINum = length(ROINames);
ROIDir = cell(ROINum,1);
for ROI = 1:ROINum
ROIDir{ROI} = fullfile(roiDir,ROINames{ROI});
end
ROIList= cell(1,ROINum);
for ii = 1:ROINum
    load(ROIDir{ii});
    ROIList{ii} = combined_img;
    ROINames{ii} = strrep(ROINames{ii},'.mat','');
end

% Now define the parameters of the timecourse
task = 'CPT_Block';
maxTime = 64;
timeVec = 1:maxTime;
cyclic = [timeVec(17:end) timeVec(1:16)];

% Load in the pt data of interest
load([task '_Pt_Data.mat']);
% ptDataSto(toRemove) = []; 
ptNum = length(ptDataSto);
% Find the time dimension
testPt = ptDataSto{1};
dims = size(testPt);
if dims(1) ~= maxTime
    error('The max time is wrong OR the matrix dimensions order needs to be changed');
end % APply checks to make sure the right data is being plotted
tval = ones(1,maxTime) .* tinv(1-alpha/2,ptNum);
alphaBon = alpha/2;
%%
for ROI = 1:ROINum
    curROI = ROIList{ROI};
    curData = zeros(ptNum,maxTime);
    for pt = 1:ptNum
        if ismember(pt,toRemove)
            continue
        end
        curPtDat = ptDataSto{pt};
        for time = 1:maxTime
            curROIData = curPtDat(time,:,:,:);
            curROIData = curROIData(curROI);
            curData(pt,time) = nanmean(curROIData);
        end
    end
    curSE  =  std(curData)/sqrt(ptNum);
    meanPtData = mean(curData);
    upperBound = meanPtData + (tval .* curSE);
    lowerBound = meanPtData - (tval .* curSE);
    % Reshape the data according to cyclic above
    meanPtData = meanPtData(cyclic);
    upperBound = upperBound(cyclic);
    lowerBound = lowerBound(cyclic);
    % Now we can conduct the bonferroni correction upon the lower bound
    siGreat = lowerBound > 0;
    cycSE   = curSE(cyclic);
    sigVals = [];
    sigValsStrBon = cell(1,1);
    ind = 1;
    for seq = length(siGreat):-1:2
        curSeqTest = ones(1,seq);
        loc = strfind(siGreat,curSeqTest);
        for poss = 1:length(loc)
            possSeq = loc(poss):(loc(poss)+seq-1);
            if isempty(strfind(sigVals,possSeq))
                sigVals = [sigVals possSeq];
                sigValsStrBon{1,ind} = possSeq;
                ind = ind + 1;
            end
        end
    end
    figure(1)
    hold on
    plot(meanPtData,'color','k','LineWidth',2);
    plot(upperBound,'color','r','LineWidth',1);
    plot(lowerBound,'color','r','LineWidth',1);
    plot([1 maxTime],[0 0],'k--')
    ylim([-0.06 0.1]);
    if localBonf
        for seq = 1:length(sigValsStrBon)
            seqLength = length(sigValsStrBon{1,seq});
            curAlpha  = alphaBon/seqLength;
            tvalBon =  ones(1,seqLength) .* tinv(1-curAlpha,ptNum);
            lowerBoundBon = meanPtData(sigValsStrBon{1,seq}) - (tvalBon .* cycSE(sigValsStrBon{1,seq}));
            sigValsStrBon{2,seq} = lowerBoundBon;
            plot(sigValsStrBon{1,seq},sigValsStrBon{2,seq},'color','g','LineWidth',1)
            bonfSigGreat = find(lowerBoundBon > 0);
        end
        saveas(gcf,fullfile(outDir,[task '_' ROINames{ROI} '_LocalBon_Fig6' '.tif']));
        save(fullfile(outDir,[task '_' ROINames{ROI} '_LocalBon_Fig6' '.mat']),'meanPtData','lowerBound','upperBound','sigValsStrBon','bonfSigGreat','cycSE');
    else
        tvalBon = ones(1,maxTime) .* tinv(1-alpha/(2*maxTime),ptNum);
        tvalBon = tvalBon(cyclic);
        lowerBoundBon = meanPtData - (tvalBon .* cycSE);
        upperBoundBon = meanPtData + (tvalBon .* cycSE);
        plot(upperBoundBon,'color','g','LineWidth',1);
        plot(lowerBoundBon,'color','g','LineWidth',1);
        bonfSigGreat = find(lowerBoundBon > mean(meanPtData(end-4:end)));
        saveas(gcf,fullfile(outDir,[task '_' ROINames{ROI} '_GlobalBon_ENDCOMP_Fig6' '.tif']));
        save(fullfile(outDir,[task '_' ROINames{ROI} '_GlobalBon_ENDCOMP_Fig6' '.mat']),'meanPtData','lowerBound','upperBound','upperBoundBon','lowerBoundBon','bonfSigGreat','cycSE');
    end

    close
end