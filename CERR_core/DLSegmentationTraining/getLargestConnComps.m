function maskOut3M = getLargestConnComps(strNum,numConnComponents,planC)
% maskOut3M = getLargestConnComps(strNum,numConnComponents,planC)
% Returns largest connected components from structure mask. No. components
% is specified using the numConnComponents input.
% ------------------------------------------------------------------------
% INPUTS
% strNum             : Structure no.
% numConnComponents  : No. largest connected components to retain.
% planC          
% ------------------------------------------------------------------------
% Example usage:
% strNum = 1;
% numConnComponents = 1;
% maskOut3M = getLargestConnComps(strNum,numConnComponents,planC);
% planC = maskToCERRStructure(maskOut3M,0,1,'largestCC',planC);
% ------------------------------------------------------------------------
% AI 10/14/19


mask3M = getStrMask(strNum,planC);

cc = bwconncomp(mask3M,26);
ccSiz = cellfun(@numel,[cc.PixelIdxList]);
%sel = ccSiz==max(ccSiz);

[~,rankV] = sort(ccSiz,'descend');
selV = rankV(1:numConnComponents);

idxV = [];
for n = 1:length(selV)
idxV = [idxV;cc.PixelIdxList{selV(n)}];
end

maskOut3M = false(size(mask3M));
maskOut3M(idxV) = true;

%planC = maskToCERRStructure(maskOut3M,0,1,'test',planC);

end

