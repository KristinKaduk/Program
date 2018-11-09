%%%to send triggers%%%
function SendSignal(onof)
global SETTINGS
global cogent
    if SETTINGS.doECG == 1
        address = hex2dec('DFB8');
        io64(cogent.io.ioObj, address, onof);      
    end
end