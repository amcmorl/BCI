
function Data = LoadDataOnline(path)

    addpath('C:\Users\emd\Documents\_code_\rg2\src\data_loader');
    addpath('C:\Users\emd\Documents\_code_\rg2\src\data_loader/v3');

    
    load([path '/RTMA_config.mat']);

     
    Data=[];
    DL.IData = [];
    DL.IncrState_R2I = [];
    
    %IncrState.R2I = [];
    %IncrState.I2F = [];

    file_idx = 1;
    files = dir([path '/QL*.bin']);
    num_files_to_read = 1;
    while(1)

        disp('==========================================================');
        fprintf('\nfile index = %d\n', file_idx);
        fprintf('num_files_to_read = %d\n', num_files_to_read);

        [Data, DL, result] = ReadMergeData_Incr(path, num_files_to_read, Data, DL);

        if ~result
            num_files_to_read = num_files_to_read + 1;
        else
            file_idx = file_idx + num_files_to_read;
            num_files_to_read = 1;
        end

        %if (file_idx == 10), break; end
        
        if ~isempty(DL.IncrState_R2I) && (DL.IncrState_R2I.LastFileIndex == length(files))
            break;
        end

        %pause
    end