function folders = readFolders( actual )
    remain = genpath(actual);
    folders = {};
    [singleSubFolder, remain] = strtok(remain, ';');
    while true
        [singleSubFolder, remain] = strtok(remain, ';');
        if isempty(singleSubFolder), break; end
        folders = [folders singleSubFolder];
    end
end

