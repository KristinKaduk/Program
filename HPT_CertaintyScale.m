function HPT_CertaintyScale(subject, run_number)
%% Isabel 25062017
% HPT_CertaintyScale('EDLU572', 1)
% HPT_CertaintyScale('test', 1)



%% CHANGED FOR TESTING
% timing
% ECG-trigger

%% define global variables

global SETTINGS
global dyn_wager

% SAVING FUNCTION'S NAME
SETTINGS.fname                           = mfilename;
SETTINGS.run_number                      = run_number;
fname_size                               = size(SETTINGS.fname);
fpath                                    = mfilename('fullpath');
SETTINGS.fpath                           = fpath(1:end-fname_size(2));

%% determine the SETUP with the according screen settings
SETTINGS.setup = 'UMG_Psychphysic';  % Setup1 OfficePC_Isabel,'OfficePC_Kristin 'UMG_Psychphysic'
% EXPERIMENT WITH ECG RECORDING (BINARY)
SETTINGS.doECG = 1; %1
Nr_Repitions = 2;  % 5 time periods x3 -> 15 trials + 5 trials for preCertainty
%!!! change repition should change when Pre occurs
NrTrials_Pre = [2 3 8 13 15]; %NrTrials_Pre = [4 6 12 15 18]; 


%% SCREEN
currentFolder = pwd ;
switch SETTINGS.setup
    case 'OfficePC_Isabel'
        SETTINGS.whichScreen = 0;
        SETTINGS.vd           = 57;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1200;
        SETTINGS.screenSize_pix =[ 0 0 SETTINGS.screen_w_pix, SETTINGS.screen_h_pix];
        
        SETTINGS.screen_w_cm  = 41;
        SETTINGS.screen_h_cm  = 30.5;
        SETTINGS.screen_frequency = 60;
        SETTINGS.screen_pixelSize = SETTINGS.screen_w_cm/ SETTINGS.screen_w_pix;
        path_save                           = [currentFolder, '\Data\'];
        %SETTINGS.inp_out                          = 'serial'; % 'parallel' if using parallel port and 'serial' if using serial port
        
    case 'OfficePC_Kristin'
        SETTINGS.whichScreen = 2;
        SETTINGS.vd           = 57;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1080;
        SETTINGS.screen_w_cm  = 41;
        SETTINGS.screen_h_cm  = 30.5;
        SETTINGS.screen_frequency = 60;
        SETTINGS.screenSize_pix =[ 0 0 SETTINGS.screen_w_pix, SETTINGS.screen_h_pix];
        SETTINGS.screen_pixelSize = SETTINGS.screen_w_cm/ SETTINGS.screen_w_pix;
        path_save                           = [currentFolder, '\Data\'];
        %SETTINGS.inp_out
        %change outFileMat
        
    case 'UMG_Psychphysic'
        SETTINGS.whichScreen  = 1;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1080;
        SETTINGS.screen_w_cm  = 60;
        SETTINGS.screen_h_cm  = 33.75;
        SETTINGS.vd           = 59;
        SETTINGS.screen_frequency = 60;                    % frame rate in Hz
        SETTINGS.screen_pixelSize = SETTINGS.screen_w_cm/ SETTINGS.screen_w_pix;
        path_save                           = [currentFolder, '\Data\'];
        SETTINGS.inp_out                    = 'parallel'; % 'parallel' if using parallel port and 'serial' if using serial port
    case 'Setup1'
        SETTINGS.whichScreen = 2;
        SETTINGS.screen_w_pix = 1920;
        SETTINGS.screen_h_pix = 1080;
        SETTINGS.screen_w_cm = 59.5;
        SETTINGS.screen_h_cm = 33;
        SETTINGS.vd           = 57;
        SETTINGS.inp_out                    = 'serial'; % 'parallel' if using parallel port and 'serial' if using serial port
        path_save                           = [currentFolder, '\Data\'];
     
        
end
%% prepare file to save it
fileNumber  = 1;

while true
    filename = [subject '_' datestr(date,'yyyy-mm-dd') '_' 'HPT' '_' num2str(fileNumber,'%02u')];
    if exist([path_save '\' filename '.mat'])
        fileNumber = fileNumber + 1;
    else
        break
    end
end


switch SETTINGS.setup
    case 'OfficePC_Kristin'
        outFileMat_localPC = [path_save filename '.mat'];
    case 'UMG_Psychphysic'
        outFileMat_localPC = [path_save filename '.mat'];
end


%% Setting parallel port
switch SETTINGS.inp_out
    case 'parallel'
        global cogent
        clear io64;
        cogent.io.ioObj = io64;
        cogent.io.status = io64(cogent.io.ioObj);
        if(cogent.io.status ~= 0)
            disp('inpout32 installation failed!')
        else
            disp('inpout32 (re)installation successful.');
        end
        address = hex2dec('DFB8');
        
    case 'serial'
end
%% TRIGGER CODES
SETTINGS.trigger.off                             = 0;
SETTINGS.trigger.inst                           = 1;
SETTINGS.trigger.resting_bs                     = 2;

SETTINGS.trigger.PreWagering_Start                = 30;
SETTINGS.trigger.PreWagering_yellowCursorAppears  = 31;
SETTINGS.trigger.PreWagering_Confirmation_appears = 32;

SETTINGS.trigger.start_count                      = 41;
SETTINGS.trigger.end_count                        = 42;
SETTINGS.trigger.HBC_report                       = 43;

SETTINGS.trigger.PostWagering_Start                = 50;
SETTINGS.trigger.PostWagering_yellowCursorAppears  = 51;
SETTINGS.trigger.PostWagering_Confirmation_appears = 52;

SETTINGS.trigger.ControlWagering_Start                = 60;
SETTINGS.trigger.ControlWagering_yellowCursorAppears  = 61;
SETTINGS.trigger.ControlWagering_Confirmation_appears = 62;

SETTINGS.trigger.ITI_Start                    = 7;
SETTINGS.trigger.ButtonUp   = 38;
SETTINGS.trigger.ButtonDown = 40;




%% Stimuli: Colors
SETTINGS.red_fix_bs                      = [160 0 0]; %dimmed red for the fixation stimulus in resting baseline period
SETTINGS.white_color                     = [255 255 255]; %white for text
SETTINGS.green_go_cue                    = [0 250 0]; %green for start/go cue of counting trials
SETTINGS.red_stop_cue                    = [255 0 0];%red for stop cue of counting trials


SETTINGS.black_cue_color                 = [0 0 0];
SETTINGS.gray_color                      = [50 50 50]; % dark gray for the rectangle, sample
SETTINGS.lightgray_color                 = [150 150 150];
SETTINGS.ITI_color                       = [0 178 255]; % dark gray for the rectangle, sample
SETTINGS.orange                          = [200 140 40];
SETTINGS.red_fix_dim                     = [240 210 210];
SETTINGS.red_fix_bright                  = SETTINGS.red_fix_dim;
SETTINGS.white_color                     = [180 180 180]; %[255 255 255];
SETTINGS.gray_wager_color                = SETTINGS.gray_color ;
SETTINGS.gray_rectangular                = {SETTINGS.gray_wager_color, SETTINGS.gray_wager_color/3};
SETTINGS.blue_color                      = [0 178 255];
SETTINGS.yellow_color                    = [160 160 0];
SETTINGS.green_color                     = [100 170 100];


%% Stimuli: wager charatersitics
SETTINGS.proportion_wager                = [1 2 ];% [post(2) and pre(1)] -> 50% pre or post-wagering
SETTINGS.wager                           = 1; % 0 = inactive, 1 = active
SETTINGS.wager_pre                       = 0; % 0 = inactive, 1 = active
SETTINGS.pre_or_post                     = 2; % 0 = random, 1 = pre_wagering, 2 = post_wagering
SETTINGS.NrOfWagers                      = 101;
SETTINGS.NrOfWagersCategories            = 6;
SETTINGS.WagerPosition_Changes           = 1;
SETTINGS.Wager_PresentedOntheScreen = 'UpToDown'; %'RightToLeft'

SETTINGS.allowed_wager_time              = 10;
SETTINGS.Time_NoCursorMovement           = 2;
SETTINGS.present_visual_feedback         = 0.5; % green square around selected wager

dyn_wager.control_condition               = 0;
dyn_wager.instructed_cue                  = 0;
%dyn_wager.instructed_cue_left             = 0;
SETTINGS.size_text                       = 40;
SETTINGS.size_text_wagering              = 30;
SETTINGS.size_text_Numbers_wagering      = 80;
SETTINGS.baseline_value                  = 10;
SETTINGS.wager_afterCorrect_1                         = '';
SETTINGS.wager_afterCorrect_2                         = '';
SETTINGS.wager_afterCorrect_3                         = '';
SETTINGS.wager_afterCorrect_4                         = '';
SETTINGS.wager_afterCorrect_5                         = '';
SETTINGS.wager_1                         = '';
SETTINGS.wager_2                         = '';
SETTINGS.wager_3                         = '';
SETTINGS.wager_4                         = '';
SETTINGS.wager_5                         = '';

SETTINGS.wager_Text_Category1                    = 'Entfernt'; %ziemlich ;höchstwahrscheinlich
SETTINGS.wager_Text_Category2                    = 'Nahe'; %ziemlich ;höchstwahrscheinlich

SETTINGS.wager_Text_1                    = 'ziemlich'; %ziemlich ;höchstwahrscheinlich
SETTINGS.wager_Text_2                    = 'eher'; %'ziemlich sicher';
SETTINGS.wager_Text_3                    = 'vielleicht'; %eventuell
SETTINGS.wager_Text_4                    = 'vielleicht';  %eventuell
SETTINGS.wager_Text_5                    = 'eher'; %'ziemlich sicher';
SETTINGS.wager_Text_6                    = 'ziemlich'; %'sicher';
SETTINGS.wager_Text = {SETTINGS.wager_Text_1 ,SETTINGS.wager_Text_2,SETTINGS.wager_Text_3,SETTINGS.wager_Text_4,SETTINGS.wager_Text_5 ,SETTINGS.wager_Text_6};
SETTINGS.wager_Text_Category = {SETTINGS.wager_Text_Category1 ,SETTINGS.wager_Text_Category2};
SETTINGS.baseline_value                  = 0;
grey_a                      = 1;
color                       = 0;
SETTINGS.Time_ChangetoSpeedyCursor = 0.5;
%% properties for the instruction and other text messages
SETTINGS.size_text                       = 30;
SETTINGS.size_text_failureMessage        = 15;

%% keys - defined
confirmKey   =13; %define confirm key (used to end)
deleteKey    =8; %define delete key (used to delete)
escapeKey    =27;
SETTINGS.rest_buttons = 40; %spacebar; 1;press the 1
SETTINGS.no_button    = 160;
SETTINGS.UP_buttons   = 38;
SETTINGS.DOWN_buttons = 40;

%% trial characteristics


%% timing variables
count_durations                     = Shuffle(repmat([24,34,44,54,64],1,Nr_Repitions));%initiates the vector of shuffled different presentation lengths in secs (one duration for each trial - excl. the instruction trial 1). will be updated in the endd of each trial.
count_durationsPreCertainty         = Shuffle(repmat([24,34,44,54,64],1,1)); 
min_duration_instr      = 2; %seconds
max_duration_instr      = 120; %seconds 120
bs_duration             = 180; %180; %180 / 3 minutes baseline
%specific counting_interval defined below per trial
stop_duration           = 1; %seconds
ITI_duration            = 20; %20; %seconds

%total duration of task ca. 8 1/2 minutes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SETTINGS.ntrials                        = length(count_durations)+ length(NrTrials_Pre)+1; %length (always one more than count_durations) NrTrials_Pre
Trial = 1; %1

%% Main Screen is set up
Screen('Preference', 'VisualDebugLevel', 1); % black PTB welcome screen
[SETTINGS.window, SETTINGS.screenSize_pix] = Screen(SETTINGS.whichScreen, 'OpenWindow'); % put 'window' on complete screen
Screen('FillRect', SETTINGS.window, [0 0 0]);               % fill whole screen black
Screen(SETTINGS.window,'Flip');
Priority(MaxPriority(SETTINGS.window)); 
%HideCursor()

%% Stimuli:Position & Size
AssertOpenGL;

SETTINGS.xcenter = SETTINGS.screenSize_pix(3)/2;
SETTINGS.ycenter = SETTINGS.screenSize_pix(4)/2;
SETTINGS.HPT_circle_Sizedeg = 1;                   % size of the targets in degrees
[SETTINGS.HPT_circle_Sizepix_x, SETTINGS.HPT_circle_Sizepix_y] = deg2pix_xy(SETTINGS.HPT_circle_Sizedeg, SETTINGS.HPT_circle_Sizedeg);

% position for stimulus circles for larger stimuli (!!):
SETTINGS.position = [(SETTINGS.xcenter-SETTINGS.HPT_circle_Sizepix_x) (SETTINGS.ycenter-SETTINGS.HPT_circle_Sizepix_x) (SETTINGS.xcenter+SETTINGS.HPT_circle_Sizepix_x) (SETTINGS.ycenter+SETTINGS.HPT_circle_Sizepix_x)]; %if used on fill oval this draws a circle in the middle of the screen with a radius of 30 pixels

%% Stimuli: Position of the Wagering
fixationPoint = 0;

TotalHight_pix = 303; % total hight of the scale
[TotalWidth_deg, TotalHight_deg]    = pix2deg_xy(NaN,TotalHight_pix);
SETTINGS.PlaceBetweenWagers         = 0; % in pixel...
SETTINGS.Wagering_w_deg             = 5; 
SETTINGS.Wagering_h_deg             = 9.11;
[SETTINGS.Wagering_rectangular_width ,SETTINGS.Wagering_rectangular_hight] = deg2pix_xy( SETTINGS.Wagering_w_deg,SETTINGS.Wagering_h_deg);
SETTINGS.Wagering_rectangular_hight = (TotalHight_pix - (SETTINGS.PlaceBetweenWagers * (SETTINGS.NrOfWagersCategories-1)))/SETTINGS.NrOfWagersCategories;

SETTINGS.WageringSquare_w_deg   = 0.7;
SETTINGS.WageringSquare_h_deg   = NaN ;


[ SETTINGS.WageringSquare_rectangular_width,SETTINGS.WageringSquare_rectangular_high ] = deg2pix_xy( SETTINGS.WageringSquare_w_deg ,SETTINGS.WageringSquare_h_deg);

%for the Certainty Categories
[vectX, vectY]                  = positioning(SETTINGS.NrOfWagersCategories,1,SETTINGS.screenSize_pix(4),SETTINGS.screenSize_pix(3), SETTINGS.PlaceBetweenWagers,SETTINGS.Wagering_rectangular_width, SETTINGS.Wagering_rectangular_hight, fixationPoint);
%shift vectX to left
vectX_Categories                = vectX + SETTINGS.WageringSquare_rectangular_width/2 +SETTINGS.PlaceBetweenWagers + SETTINGS.Wagering_rectangular_width/2;

BarsPlacement_WagersCategories  = FourPoints(vectX_Categories, vectY,SETTINGS.Wagering_rectangular_hight, SETTINGS.Wagering_rectangular_width);
% Richtig/Falsch positioning 
SETTINGS.WagersCategories2_rectangular_hight = SETTINGS.Wagering_rectangular_hight*3 + SETTINGS.PlaceBetweenWagers*2; 
SETTINGS.WagersCategories2_rectangular_width = SETTINGS.Wagering_rectangular_width;
vectX_Categories2               = vectX - (SETTINGS.WageringSquare_rectangular_width/2 +SETTINGS.PlaceBetweenWagers + SETTINGS.WagersCategories2_rectangular_width/2);
[X, vectY_Categories2]          = positioning(SETTINGS.NrOfWagersCategories/3,1,SETTINGS.screenSize_pix(4),SETTINGS.screenSize_pix(3), SETTINGS.PlaceBetweenWagers,SETTINGS.WagersCategories2_rectangular_width, SETTINGS.WagersCategories2_rectangular_hight, fixationPoint);

amountColumns = 1; vectY_Squares =[]; 

SETTINGS.WageringSquare_rectangular_hight = TotalHight_pix/SETTINGS.NrOfWagers; 
[vectX, vectY_Squares]                  = positioning(SETTINGS.NrOfWagers,1,SETTINGS.screenSize_pix(4),SETTINGS.screenSize_pix(3), 0,SETTINGS.WageringSquare_rectangular_width, SETTINGS.WageringSquare_rectangular_hight, fixationPoint);
BarsPlacement_Wagers = FourPoints(vectX, vectY_Squares,SETTINGS.WageringSquare_rectangular_hight, SETTINGS.WageringSquare_rectangular_width);

SETTINGS.WageringFrame_size_deg = NaN;
[SETTINGS.WageringFrame_width_pix, SETTINGS.WageringFrame_hight_pix ] = deg2pix_xy( SETTINGS.WageringSquare_w_deg,SETTINGS.WageringFrame_size_deg);
SETTINGS.WageringFrame_hight_pix = SETTINGS.WageringSquare_rectangular_hight;

vectY_Categories2(1) = BarsPlacement_Wagers{1}(4)- (TotalHight_pix/4);
vectY_Categories2(2) = BarsPlacement_Wagers{SETTINGS.NrOfWagers}(2)+ (TotalHight_pix/4);

BarsPlacement_WagersCategories2  = FourPoints(vectX_Categories2, vectY_Categories2,SETTINGS.WagersCategories2_rectangular_hight, SETTINGS.WagersCategories2_rectangular_width);


%% start with stimuli
RunStartTime = GetSecs;
SETTINGS.RunStartTime = RunStartTime;

while Trial <= (SETTINGS.ntrials) % Main Loop starts
    %% Variables to be updated
    
    %case variables
    counted_heartbeats=0;
    
    counting_interval=0;
    
    %timing variables
    start_time_inst=NaN;
    start_time_inst_run=NaN;
    BS_start_time = NaN;
    BS_start_time_run = NaN;
    Go_start_time = NaN;
    Go_start_time_run = NaN;
    Stop_start_time = NaN;
    Stop_start_time_run = NaN;
    count_report_start_time = NaN;%question asking for heartbeat count report appears
    count_report_start_time_run=NaN;
    count_report_stop_time = NaN; %enter is pressed, count report sent
    count_report_stop_time_run = NaN;
    ITI_start_time = NaN;
    ITI_start_time_run = NaN;
    trial_finish_time =NaN;
    trial_finish_time_run=NaN;
    frame= 0;
    Wager_number_yellow                       =NaN;
    wager_number_yellow_post                  =NaN;
    wager_number_yellow_pre                   =NaN;
    wager_choosen                             =NaN;
    wager_choosen_pre                         =NaN;
    wager_choosen_post                        =NaN; 
    value_choosen                             =NaN;
    wager_control_completed                   =NaN;
    position_wager_chosen                     =NaN;
    %wager variables
    SETTINGS.unsuccess                      = 0;
    rest_sensor_hold_success                = 0;
    
    amount_rectangular                      = 0;
    position_wager_chosen_pre               = 0;
    position_wager_chosen_post              = 0;
    Amount_clicks                           = 0;
    Amount_clicks_wagering_pre              = 0;
    Amount_clicks_wagering_post             = 0;
    low_wager_down_right_pre                = NaN;
    side_low_wager_pre                      = NaN;
    low_wager_down_right_post               = NaN;
    side_low_wager_post                     = NaN;
    wagering_or_controll_wagering_post      = NaN;
    wagering_or_controll_wagering_pre       = NaN;
    
    Wager_start_time                           = NaN;
    Wager_start_time_wagering_pre              = NaN;
    Wager_start_time_wagering_pre_run          = NaN;
    Wager_start_time_wagering_post             = NaN;
    Wager_start_time_wagering_post_run         = NaN;
    Wager_time_decided                         = NaN;
    Wager_time_decided_wagering_pre            = NaN;
    Wager_time_decided_wagering_pre_run        = NaN;
    Wager_time_decided_wagering_post           = NaN;
    Wager_time_decided_wagering_post_run       = NaN;
    Wager_time_decided_first_click_post        = NaN;
    Wager_time_decided_first_click_pre         = NaN;
    Wager_time_decided_first_click_post_run    = NaN;
    Wager_time_decided_first_click_pre_run     = NaN;
    Wager_time_decided_first_click             = NaN;
    Wager_time_1streleasedButton_post          = NaN;
    Wager_time_1streleasedButton_post_run      = NaN;
    Wager_time_1streleasedButton_pre           = NaN;
    Wager_time_1streleasedButton_pre_run       = NaN;
    Wager_time_1streleasedButton               = NaN;
    Wager_time_yellowCursor_appears_post          = NaN;
    Wager_time_yellowCursor_appears_post_run      = NaN;
    Wager_time_yellowCursor_appears_pre           = NaN;
    Wager_time_yellowCursor_appears_pre_run       = NaN;
    Wager_time_yellowCursor_appears               = NaN;
    Wager_time_Confirmation_appears               = NaN;
    Wager_time_Confirmation_appears_post          = NaN;
    Wager_time_Confirmation_appears_post_run      = NaN;
    Wager_time_Confirmation_appears_pre           = NaN;
    Wager_time_Confirmation_appears_pre_run       = NaN;
    Wager_end_time_wagering_post                  = NaN;
    Wager_end_time_wagering_post_run              = NaN;
    Wager_end_time_wagering_pre                   = NaN;
    Wager_end_time_wagering_pre_run               = NaN;
    Wager_end_time_wagering                       = NaN;
    Wager_instructed_cue_post                     = NaN;
    Wager_instructed_cue_pre                     = NaN;    
    Wager_time_ButtonPressUP = [];
    Wager_time_ButtonPress = [];
    Wager_time_ButtonPressDOWN= [];
    Wager_time_ButtonPressUP_post             = NaN;
    Wager_time_ButtonPress_post               = NaN;
    Wager_time_ButtonPressDOWN_post           = NaN;
    Wager_time_ButtonPressUP_pre              = NaN;
    Wager_time_ButtonPress_pre                = NaN;
    Wager_time_ButtonPressDOWN_pre            = NaN;    
    %% 1ST trial: STARTS WITH INSTRUCTION & BASELINE PERIOD
    
    %%%%% draw welcome screen with mini instruction (only in trial 1)%%%%%
    if Trial==1 %trial 1 is used for instruction + the baseline period!
        
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        
        Screen('TextSize',SETTINGS.window,28); %sets textsize for instructions
        DrawFormattedText(SETTINGS.window,'Willkommen!\n\nDie Aufgabe beginnt mit einem Ruheintervall, in dem Sie lediglich\n\nentspannt auf den Bildschirm schauen sollen.\n\nSobald der grüne Kreis erscheint, achten Sie auf Ihren Körper und \n\nzählen  leise alle Herzschläge. Sobald der rote Kreis auftaucht, \n\nstoppen Sie das Zählen und geben die Anzahl aller wahrgenommenen \n\nHerzschläge an.\n\nDanach sollen Sie angeben, wie sicher Sie sich sind, dass Ihre \n\nAngabe korrekt war.\n\nBitte drücken Sie ENTER um zu beginnen.','centerblock','center',SETTINGS.white_color);
        Screen(SETTINGS.window,'Flip');
        start_time_inst=GetSecs;
        %send instruction trigger (1)
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.inst);
            WaitSecs(0.003);
        else
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        
        start_time_inst_run   = start_time_inst - RunStartTime;
        keyIsDown=0;
        while GetSecs-start_time_inst <max_duration_instr %set the limit high so that one has a long period where the key can be pressed to proceed and leave the loop
            [keyIsDown, ~, keyCode] = KbCheck;
            quit=0;
            if keyIsDown
                if keyCode(escapeKey) %%if escape key is pressed in the instruction period: close screen
                    ShowCursor;
                    %fclose(outfile);
                    quit=1;
                    break;
                elseif keyCode(confirmKey) && GetSecs - start_time_inst >min_duration_instr %gotta read the instruction screen for at least 2 seconds. can then proceed with enter
                    break;
                end
            end
        end
        if quit==1 %call for quit variable to get out of the overall loop in case the quit condition had been fulfilled earlier in the trial!
            break;
        else
        end
        
        
        
        %%%%% draw central fixation point for baseline period%%%%%
        
        
        Screen('FillOval', SETTINGS.window, SETTINGS.red_fix_bs,SETTINGS.position,10);
        Screen(SETTINGS.window,'Flip');
        BS_start_time = GetSecs; %fuer if verwenden
        %send baseline trigger (2)
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.resting_bs);
            WaitSecs(0.003);
        else
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        
        BS_start_time_run = BS_start_time-RunStartTime; %baseline-trial start time! (for the stimulus trials we got a different time stamp : stimulus appeared (see below)
        keyIsDown=0;
        while GetSecs - BS_start_time < bs_duration %20
            [keyIsDown, ~, keyCode] = KbCheck;
            quit=0;
            if keyIsDown
                if keyCode(escapeKey)
                    ShowCursor;
                    %fclose(outfile);
                    quit=1;
                    break;
                end
            end
        end
        if quit==1
            break;
        end
        
        
        %%%% 2ND AND  CONSECUTIVE trialS:
        
    elseif Trial>1
        
                if SETTINGS.pre_or_post ==1 % always pre wagering
                    dyn_wager.control_or_wager = 1;
                elseif SETTINGS.pre_or_post ==2 % always post wagering
                    dyn_wager.control_or_wager = 2;
                elseif SETTINGS.pre_or_post == 0 % randomised between post & pre-wagering
                    dyn_wager.control_or_wager   = 1;
                end
       if Trial == NrTrials_Pre(1) ||  Trial == NrTrials_Pre(2) || Trial == NrTrials_Pre(3) || Trial == NrTrials_Pre(4) || Trial == NrTrials_Pre(5) %!!!the same for post!!!!
           Screen('TextSize',SETTINGS.window,28); %sets textsize for instructions
           DrawFormattedText(SETTINGS.window,'Bitte gib hier an wie du deine allgemeine Leistung in der Aufgabe - Wahrnehmung des Herzschlages - einschätzt.  Sind Sie oft...  \n\n\n Zum Starten einmal die Pfeiltaste nach UNTEN drücken.',500,500,SETTINGS.white_color);
           Screen(SETTINGS.window,'Flip');
            %(0) PRE-DECISION WAGERING
            if SETTINGS.wager
                
                dyn_wager.control_or_wager = 1;
                switch dyn_wager.control_or_wager
                    case 1 % pre-wagering
                        dyn_wager.control_condition = 0;
                        dyn_wager.Wagering = 1;
                    case 2 % control
                        dyn_wager.Wagering = 0;
                        dyn_wager.control_condition = 1;
                        dyn_wager.instructed_cue = ig_randsample(1:SETTINGS.NrOfWagersCategories, 1, true, repmat(100/SETTINGS.NrOfWagersCategories,1,SETTINGS.NrOfWagersCategories) )*10;
                end
                
                if SETTINGS.WagerPosition_Changes == 1
                    low_wager_down_right = ig_randsample([1 0], 1, true, [50 50]); % option 3..means that the Option Wrong wagers are presented on the down part of the screen
                else
                    low_wager_down_right = 1;
                end
                position_wager_high_low(low_wager_down_right, BarsPlacement_WagersCategories,BarsPlacement_Wagers,BarsPlacement_WagersCategories2);
                low_wager_down_right_pre      = low_wager_down_right;
                
                while 1
                    if get_hands_state == SETTINGS.rest_buttons %press the button initiates to show the cursor to wager
                        wagering_graphic(grey_a,amount_rectangular,frame,color, BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2)
                        Wager_start_time                    = GetSecs;
                        Wager_start_time_wagering_pre = GetSecs;
                        Wager_start_time_wagering_pre_run = Wager_start_time_wagering_pre - RunStartTime;
                        break
                    end
                end
                
                if dyn_wager.control_or_wager == 2
                    if SETTINGS.doECG == 1; SendSignal(SETTINGS.trigger.PreWagering_Start);
                        WaitSecs(0.001); %time until the screen is updated
                    end
                elseif dyn_wager.control_or_wager == 1
                    if SETTINGS.doECG == 1; SendSignal(SETTINGS.trigger.ControlWagering_Start);
                        WaitSecs(0.001); %time until the screen is updated
                    end
                end
                if SETTINGS.doECG == 1 ;SendSignal(SETTINGS.trigger.off );    end
                
                
                while 1
                    if GetSecs - Wager_start_time >= SETTINGS.allowed_wager_time %Wagertime is expired
                        break
                    end
                    if get_hands_state == SETTINGS.rest_buttons %releasing the button initiates to show the cursor to wager
                        Wager_time_1streleasedButton  = GetSecs;
                        [Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN, Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click, Wager_number_yellow ,Amount_clicks, Wager_time_yellowCursor_appears ,wager_choosen ,value_choosen ,amount_rectangular ,wager_control_completed ,Wager_time_decided] = wager(Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN,Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click,  Wager_number_yellow ,Amount_clicks,Wager_time_decided,  wager_choosen,low_wager_down_right,value_choosen,Wager_start_time, BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2);


                        break
                    end
                end
                position_wager_chosen_pre                 = amount_rectangular;
                wager_choosen_pre                         = wager_choosen;
                wager_number_yellow_pre                    = Wager_number_yellow; 
                wagering_or_controll_wagering_pre         = dyn_wager.control_condition;
                Wager_time_1streleasedButton_pre          = Wager_time_1streleasedButton;
                Wager_time_1streleasedButton_pre_run      = Wager_time_1streleasedButton_pre - RunStartTime;
                Wager_time_yellowCursor_appears_pre       = Wager_time_yellowCursor_appears;
                Wager_time_yellowCursor_appears_pre_run   = Wager_time_yellowCursor_appears_pre - RunStartTime;
                Wager_time_decided_first_click_pre        = Wager_time_decided_first_click;
                Wager_time_decided_first_click_pre_run    = Wager_time_decided_first_click_pre - RunStartTime;
                Wager_time_decided_wagering_pre           = Wager_time_decided;
                Wager_time_decided_wagering_pre_run       = Wager_time_decided_wagering_pre - RunStartTime;
                Wager_time_Confirmation_appears_pre       = Wager_time_Confirmation_appears;
                Wager_time_Confirmation_appears_pre_run   = Wager_time_Confirmation_appears_pre - RunStartTime;
                Wager_end_time_wagering_pre               = Wager_end_time_wagering;
                Wager_end_time_wagering_pre_run           = Wager_end_time_wagering_pre - RunStartTime;
                Amount_clicks_wagering_pre                = Amount_clicks;
                Wager_instructed_cue_pre                  = dyn_wager.instructed_cue;
                Wager_time_ButtonPressUP_pre              = Wager_time_ButtonPressUP ;
                Wager_time_ButtonPress_pre                = Wager_time_ButtonPress;
                Wager_time_ButtonPressDOWN_pre            = Wager_time_ButtonPressDOWN;
            end
        end
        
        %(I) GO CUE: START COUNTING
        
        %%%%% draw green circle and beep as go cue to start counting heartbeats %%%%%
        
        
        Screen('FillOval', SETTINGS.window, SETTINGS.green_go_cue,SETTINGS.position,10);
        beep1000 = MakeBeep(1000,0.1,48000); %make beep before flipping screen cause it takes longer
        sound(beep1000,48000);
        Screen(SETTINGS.window,'Flip');
        
        Go_start_time = GetSecs;
        
        %send trigger to start counting (3)
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.start_count);
            WaitSecs(0.003);
            
        else
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        Go_start_time_run = Go_start_time-RunStartTime;
        
        if dyn_wager.control_or_wager == 2 %Post-Certainty
        counting_interval= count_durations(1);
        elseif dyn_wager.control_or_wager == 1
        counting_interval= count_durationsPreCertainty(1);
        end
        
        keyIsDown=0;
        while GetSecs - Go_start_time <counting_interval %still gotta save that randomly picked duration somewhere!! bzw. den eingangs durch "shuffle" festgelegten vektor fuer diesen durchgang der funktion (subject)
            [keyIsDown, ~, keyCode] = KbCheck;
            quit=0;
            if keyIsDown
                if keyCode(escapeKey) %if escape key is pressed in the baseline fixation period: close screen
                    ShowCursor;
                    %fclose(outfile);
                    quit=1;
                    break;
                end
            end
        end
        if quit==1
            break;
        end
        
        
        
        
        %(II) STOP CUE: STOP COUNTING
        
        %%%%% draw red circle and beep as stop cue for counting (when this pops up: stop counting heartbeats)%%%%%
        
        %send trigger to stop counting (4)
        
        Screen('FillOval', SETTINGS.window, SETTINGS.red_stop_cue,SETTINGS.position,10);
        beep500 = MakeBeep(500,0.1,48000);
        sound(beep500,48000);
        Screen(SETTINGS.window,'Flip');
        
        Stop_start_time = GetSecs;
        
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.end_count);
            WaitSecs(0.003);
            
        else
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        
        
        Stop_start_time_run = Stop_start_time-RunStartTime;
        
        keyIsDown=0;
        while GetSecs - Stop_start_time <stop_duration %short duration of stop cue
            [keyIsDown, ~, keyCode] = KbCheck;
            quit=0;
            if keyIsDown
                if keyCode(escapeKey)
                    ShowCursor;
                    %fclose(outfile);
                    quit=1;
                    break;
                end
            end
        end
        if quit==1
            break;
        end
        
        
        
        %(III) REPORT NO. OF BEATS
        
        %%%%% ask for heartbeat count report %%%%%
        
        
        %Get responses from what subjects typed
        
        KbName('UnifyKeyNames'); %used for cross-platform compatibility of keynaming
        KbQueueCreate; %creates cue using defaults
        KbQueueStart;  %starts the cue
        Screen('TextSize',SETTINGS.window,28); %sets textsize for instructions
        DrawFormattedText(SETTINGS.window,'Wie viele Herzschläge haben Sie wahrgenommen?\n\nGeben Sie ihre Antwort mit dem Nummernblock ein und bestätigen Sie mit ENTER.',50,70,SETTINGS.white_color);
        Screen(SETTINGS.window,'Flip');
        count_report_start_time = GetSecs;
        %send trigger for heartbeat-count report (5)
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.HBC_report);
            WaitSecs(0.003);
        else
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        else
        end
        count_report_start_time_run = count_report_start_time-RunStartTime;
        enterpressed=0; %initializes loop flag
        AsteriskBuffer=[]; %initializes buffer
        while ( enterpressed==0 )
            [ pressed, firstPress]=KbQueueCheck; %checks for keys
            enterpressed=firstPress(confirmKey);%press confirm key to terminate each response
            if (pressed && ~enterpressed) %keeps track of key-presses and draws text
                if firstPress(deleteKey) %if delete key then erase last key-press
                    AsteriskBuffer=AsteriskBuffer(1:end-1); %erase last key-press
                else %otherwise add to buffer
                    firstPress(find(firstPress==0))=NaN; %little trick to get rid of 0s
                    [endtime Index]=min(firstPress); % gets the RT of the first key-press and its ID
                    AsteriskBuffer=[AsteriskBuffer KbName(Index)]; %adds key to buffer
                end
                Screen('TextSize',SETTINGS.window,28); %sets textsize for instructions
                DrawFormattedText(SETTINGS.window,'Wie viele Herzschläge haben Sie wahrgenommen?\n\nGeben Sie ihre Antwort mit dem Nummernblock ein und bestätigen Sie mit ENTER.',50,70,SETTINGS.white_color);
                Screen('TextSize',SETTINGS.window,40);  %sets textsize for keys pressed
                DrawFormattedText(SETTINGS.window, AsteriskBuffer, 'center','center', SETTINGS.white_color); %draws keyspressed
                Screen(SETTINGS.window,'Flip');
            end
            WaitSecs(.01); % put in small interval to allow other system events
        end
        count_report_stop_time = GetSecs; %enter is pressed, count report sent
        count_report_stop_time_run = count_report_stop_time-RunStartTime;
        counted_heartbeats=str2double(AsteriskBuffer); %assign the report input to counted_heartbeats variable
        
        
        
        
        %% (IV) POST-REPORT CONFIDENCE (Wagering-style)
        Wager_start_time = NaN;     Wager_time_decided                         = NaN;
        dyn_wager.control_or_wager = 2;

        if SETTINGS.wager
            if dyn_wager.control_or_wager == 1
           Screen('TextSize',SETTINGS.window,28); %sets textsize for instructions
           DrawFormattedText(SETTINGS.window,'Bitte jetzt den Cursor zu dem Blauen Kästchen navigieren.   \n\n Zum Starten einmal die Pfeiltaste nach UNTEN drücken.',500,500,SETTINGS.white_color);
           Screen(SETTINGS.window,'Flip');
            elseif  dyn_wager.control_or_wager == 2
            Screen('TextSize',SETTINGS.window,SETTINGS.size_text); %sets textsize for instructions
            DrawFormattedText(SETTINGS.window,'Wie sicher sind Sie, dass die soeben von Ihnen angegebene Anzahl an Herzschlägen \n mit den gemessenen Herzschlägen übereinstimmt?  \n\n Zum Starten einmal die Pfeiltaste nach UNTEN drücken.',500,500,SETTINGS.white_color);
            Screen(SETTINGS.window,'Flip');

            end
           
            switch dyn_wager.control_or_wager
                case 2 % post-wagering
                    dyn_wager.control_condition = 0;
                    dyn_wager.Wagering = 2;
                    
                case 1 % control
                    dyn_wager.Wagering = 0;
                    dyn_wager.control_condition = 1;
                    dyn_wager.instructed_cue = ig_randsample(1:SETTINGS.NrOfWagersCategories, 1, true, repmat(100/SETTINGS.NrOfWagersCategories,1,SETTINGS.NrOfWagersCategories) )*10;
            end
            
            
            
            if SETTINGS.WagerPosition_Changes == 1
                low_wager_down_right = ig_randsample([0 1], 1, true, [50 50]); 
            else
                low_wager_down_right = 1; % Sure to be Close is presented on the top of the screen
            end
            
            position_wager_high_low(low_wager_down_right, BarsPlacement_WagersCategories,BarsPlacement_Wagers,BarsPlacement_WagersCategories2);
            low_wager_down_right_post      = low_wager_down_right;
            
            while 1
                if get_hands_state == SETTINGS.rest_buttons %press the button initiates to show the cursor to wager
                    wagering_graphic(grey_a,amount_rectangular,frame,color, BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2)
                    Wager_start_time                    = GetSecs;
                    Wager_start_time_wagering_post      = GetSecs;
                    Wager_start_time_wagering_post_run  = Wager_start_time_wagering_post - RunStartTime;
                    break
                end
            end
            
            if dyn_wager.control_or_wager == 2
                if SETTINGS.doECG == 1; SendSignal(SETTINGS.trigger.PostWagering_Start);
                    WaitSecs(0.001); %time until the screen is updated
                end
            elseif dyn_wager.control_or_wager == 1
                if SETTINGS.doECG == 1; SendSignal(SETTINGS.trigger.ControlWagering_Start);
                    WaitSecs(0.001); %time until the screen is updated
                end
            end
            if SETTINGS.doECG == 1 ;SendSignal(SETTINGS.trigger.off );    end
            
            
            while 1
                if GetSecs - Wager_start_time >= SETTINGS.allowed_wager_time %Wagertime is expired
                    break
                end
                if get_hands_state ~= SETTINGS.rest_buttons %press the button initiates to show the cursor to wager
                    Wager_time_1streleasedButton  = GetSecs;
                    [Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN, Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click, Wager_number_yellow ,Amount_clicks, Wager_time_yellowCursor_appears ,wager_choosen ,value_choosen ,amount_rectangular ,wager_control_completed ,Wager_time_decided] = wager(Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN,Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click,  Wager_number_yellow ,Amount_clicks,Wager_time_decided,  wager_choosen,low_wager_down_right,value_choosen,Wager_start_time, BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2);
                    break
                end
            end
            position_wager_chosen_post                 = amount_rectangular;
            wager_choosen_post                         = wager_choosen;
            wager_number_yellow_post                   = Wager_number_yellow;
            wagering_or_controll_wagering_post         = dyn_wager.control_condition;
            Wager_time_decided_wagering_post           = Wager_time_decided;
            Wager_time_decided_wagering_post_run       = Wager_time_decided_wagering_post - RunStartTime;
            Wager_time_1streleasedButton_post          = Wager_time_1streleasedButton;
            Wager_time_1streleasedButton_post_run      = Wager_time_1streleasedButton_post- RunStartTime;
            Wager_time_yellowCursor_appears_post       = Wager_time_yellowCursor_appears;
            Wager_time_yellowCursor_appears_post_run   = Wager_time_yellowCursor_appears_post - RunStartTime;
            Amount_clicks_wagering_post                = Amount_clicks;
            Wager_time_decided_first_click_post        = Wager_time_decided_first_click;
            Wager_time_decided_first_click_post_run    = Wager_time_decided_first_click_post - RunStartTime;
            Wager_time_Confirmation_appears_post       = Wager_time_Confirmation_appears;
            Wager_time_Confirmation_appears_post_run   = Wager_time_Confirmation_appears_post - RunStartTime;
            Wager_end_time_wagering_post               = Wager_end_time_wagering;
            Wager_end_time_wagering_post_run           = Wager_end_time_wagering_post - RunStartTime;
            Wager_instructed_cue_post                  = dyn_wager.instructed_cue;
            Wager_time_ButtonPressUP_post              = Wager_time_ButtonPressUP ;
            Wager_time_ButtonPress_post                = Wager_time_ButtonPress;
            Wager_time_ButtonPressDOWN_post            = Wager_time_ButtonPressDOWN;
        end
        
        
        %% update the duration shuffle vector
        %-> in elseif condition cause otherwise updated in baseline trial==1 already
       if Trial == NrTrials_Pre(1) ||  Trial == NrTrials_Pre(2) || Trial == NrTrials_Pre(3) || Trial == NrTrials_Pre(4) || Trial == NrTrials_Pre(5)
           count_durationsPreCertainty=count_durationsPreCertainty(2:end);
        else
            count_durations=count_durations(2:end);
        end
        
    end
    
    %% END
    trial_finish_time = GetSecs;
    trial_finish_time_run = GetSecs-RunStartTime;
    
    %% save Variales
    % black screen for the start of the intertrail interval
    
    Screen(SETTINGS.window,'Flip');
    fprintf('T: %d\t  yellowCursorWagPre: %.2f\t WagPre: %.2f\t    WagPost: %.2f\t WagPost: %.2f  \n', Trial,  wager_number_yellow_pre, wager_choosen_pre, wager_number_yellow_post, wager_choosen_post);
    Time_startsaving = GetSecs - RunStartTime;
    
    trial(Trial).trial                       =Trial;
    
    %case variables
    trial(Trial).counting_interval           = counting_interval; %save the length of the counting interval for every trial (out of vector "count_durations")
    trial(Trial).counted_heartbeats          = counted_heartbeats; %save number of counted/reported heartbeats for each trial, .e. each counting interval
    
    
    %timing variables
    trial(Trial).start_time_inst         = start_time_inst;
    trial(Trial).start_time_inst_run     = start_time_inst_run;
    trial(Trial).BS_start_time           = BS_start_time;
    trial(Trial).BS_start_time_run       = BS_start_time_run;
    trial(Trial).Go_start_time           = Go_start_time;
    trial(Trial).Go_start_time_run       = Go_start_time_run;
    trial(Trial).Stop_start_time         = Stop_start_time;
    trial(Trial).Stop_start_time_run     = Stop_start_time_run;
    trial(Trial).count_report_start_time = count_report_start_time;%question asking for heartbeat count report appears
    trial(Trial).count_report_start_time_run =count_report_start_time_run;
    trial(Trial).count_report_stop_time      = count_report_stop_time; %enter is pressed, count report sent
    trial(Trial).count_report_stop_time_run  = count_report_stop_time_run;
    trial(Trial).trial_finish_time           =trial_finish_time;
    trial(Trial).trial_finish_time_run       =trial_finish_time_run;
    
    %wagering variables
    trial(Trial).wagering_or_controll_wagering_pre         = wagering_or_controll_wagering_pre ;
    trial(Trial).position_wager_chosen_pre                 = position_wager_chosen_pre ;
    trial(Trial).Amount_clicks_wagering_pre                = Amount_clicks_wagering_pre ;
    trial(Trial).low_wager_down_right_pre                  = low_wager_down_right_pre ;
    trial(Trial).wagering_or_controll_wagering_post        = wagering_or_controll_wagering_post ;
    trial(Trial).position_wager_chosen_post                = position_wager_chosen_post ;
    trial(Trial).Amount_clicks_wagering_post               = Amount_clicks_wagering_post ;
    trial(Trial).low_wager_down_right_post                 = low_wager_down_right_post ;
    trial(Trial).wager_choosen_post                        = wager_choosen_post; 
    trial(Trial).wager_choosen_pre                         = wager_choosen_pre;
    trial(Trial).value_choosen                             = value_choosen;
    trial(Trial).wager_number_yellow_post                  = wager_number_yellow_post;
    trial(Trial).wager_number_yellow_pre                   = wager_number_yellow_pre;
    trial(Trial).Wager_start_time_wagering_pre             = Wager_start_time_wagering_pre;
    trial(Trial).Wager_start_time_wagering_pre_run         = Wager_start_time_wagering_pre_run ;
    trial(Trial).Wager_time_decided_wagering_pre           = Wager_time_decided_wagering_pre;
    trial(Trial).Wager_time_decided_wagering_pre_run       = Wager_time_decided_wagering_pre_run ;
    trial(Trial).Wager_time_decided_first_click_pre        = Wager_time_decided_first_click_pre ;
    trial(Trial).Wager_time_decided_first_click_pre_run    = Wager_time_decided_first_click_pre_run;
    trial(Trial).Wager_time_1streleasedButton_pre          = Wager_time_1streleasedButton_pre;
    trial(Trial).Wager_time_1streleasedButton_pre_run      = Wager_time_1streleasedButton_pre_run ;
    trial(Trial).Wager_time_yellowCursor_appears_pre       = Wager_time_yellowCursor_appears_pre;
    trial(Trial).Wager_time_yellowCursor_appears_pre_run   = Wager_time_yellowCursor_appears_pre_run ;
    trial(Trial).Wager_end_time_wagering_pre               = Wager_end_time_wagering_pre;
    trial(Trial).Wager_end_time_wagering_pre_run           = Wager_end_time_wagering_pre_run ;
    trial(Trial).Wager_time_Confirmation_appears_pre       = Wager_time_Confirmation_appears_pre ;
    trial(Trial).Wager_time_Confirmation_appears_pre_run   = Wager_time_Confirmation_appears_pre_run ;
    
    %variables of post-wagering
    trial(Trial).Wager_start_time_wagering_post             = Wager_start_time_wagering_post;
    trial(Trial).Wager_start_time_wagering_post_run         = Wager_start_time_wagering_post_run ;
    trial(Trial).Wager_time_decided_wagering_post           = Wager_time_decided_wagering_post;
    trial(Trial).Wager_time_decided_wagering_post_run       = Wager_time_decided_wagering_post_run ;
    trial(Trial).Wager_time_decided_first_click_post        = Wager_time_decided_first_click_post ;
    trial(Trial).Wager_time_decided_first_click_post_run    = Wager_time_decided_first_click_post_run;
    trial(Trial).Wager_time_1streleasedButton_post          = Wager_time_1streleasedButton_post;
    trial(Trial).Wager_time_1streleasedButton_post_run      = Wager_time_1streleasedButton_post_run ;
    trial(Trial).Wager_time_yellowCursor_appears_post       = Wager_time_yellowCursor_appears_post;
    trial(Trial).Wager_time_yellowCursor_appears_post_run   = Wager_time_yellowCursor_appears_post_run ;
    trial(Trial).Wager_end_time_wagering_post               = Wager_end_time_wagering_post;
    trial(Trial).Wager_end_time_wagering_post_run           = Wager_end_time_wagering_post_run ;
    trial(Trial).Wager_time_Confirmation_appears_post       = Wager_time_Confirmation_appears_post ;
    trial(Trial).Wager_time_Confirmation_appears_post_run   = Wager_time_Confirmation_appears_post_run ;
    trial(Trial).Wager_instructed_cue_post                  = Wager_instructed_cue_post ;
    trial(Trial).Wager_instructed_cue_pre                   = Wager_instructed_cue_pre ;
    trial(Trial).Wager_time_ButtonPressUP_post              = Wager_time_ButtonPressUP_post ;
    trial(Trial).Wager_time_ButtonPress_post                = Wager_time_ButtonPress_post;
    trial(Trial).Wager_time_ButtonPressDOWN_post            = Wager_time_ButtonPressDOWN_post;
    trial(Trial).Wager_time_ButtonPressUP_pre               = Wager_time_ButtonPressUP_pre ;
    trial(Trial).Wager_time_ButtonPress_pre                 = Wager_time_ButtonPress_pre;
    trial(Trial).Wager_time_ButtonPressDOWN_pre             = Wager_time_ButtonPressDOWN_pre;    
    trial(Trial).unsuccess                                  = SETTINGS.unsuccess;
    
    
    
    if Trial > 1
        save(outFileMat_localPC,'trial','-append');
    else
        save(outFileMat_localPC,'trial','SETTINGS');
    end
    
    
    %% (V) INTER-TRIAL INTERVAL
    if Trial>1
        Time_endsaving = GetSecs - RunStartTime;
        Time_saving = Time_endsaving - Time_startsaving;
        
        %%%%% draw central fixation point for ITI %%%%%
        Screen('FillOval', SETTINGS.window, SETTINGS.red_fix_bs,SETTINGS.position,10); %open fixation again
        Screen(SETTINGS.window,'Flip');
        %send trigger for ITI (7)
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.ITI_Start);
            WaitSecs(0.003);
        end
        %set trigger to 0
        if SETTINGS.doECG == 1
            SendSignal(SETTINGS.trigger.off );
        end
        
        ITI_start_time = GetSecs;
        ITI_start_time_run = ITI_start_time-RunStartTime;
        keyIsDown=0;
        while GetSecs - ITI_start_time < (ITI_duration-Time_saving); %<20 secs inter trial/i.e. inter-counting-period interval
            [keyIsDown, ~, keyCode] = KbCheck;
            if keyIsDown;
                if keyCode(escapeKey);
                    ShowCursor;
                    %fclose(outfile);
                    break;
                end
            end
        end
    else
    end
    
    
    
    %% update trial number
    Trial = Trial + 1;
    
end %main loop ends, when number of current trial (trial) = number of total trials (ntrials)
ShowCursor(); %shows the cursor > both  commands maybe at the end of while loop?
Screen('CloseAll');


end