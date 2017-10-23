remain = genpath(pwd);
folders = {};
[singleSubFolder, remain] = strtok(remain, ';');
while true
    [singleSubFolder, remain] = strtok(remain, ';');
    if isempty(singleSubFolder), break; end
    folders = [folders singleSubFolder];
end
for val = folders
    fold = val{1};
    
    tok = val{1}(end-1:end)
end