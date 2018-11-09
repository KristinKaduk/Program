%% Wager Grafik
function [Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN, Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click, Wager_number_yellow ,Amount_clicks, Wager_time_yellowCursor_appears ,wager_choosen ,value_choosen ,amount_rectangular ,wager_control_completed ,Wager_time_decided] = wager(Wager_time_ButtonPressUP,Wager_time_ButtonPress,Wager_time_ButtonPressDOWN, Wager_end_time_wagering, Wager_time_Confirmation_appears, Wager_time_decided_first_click,  Wager_number_yellow ,Amount_clicks,Wager_time_decided, wager_choosen,low_wager_down_right,value_choosen,Wager_start_time,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2 )

Wager_time_ButtonPress = []; 
global SETTINGS
global dyn_wager
if dyn_wager.Wagering     == 1
    trigger.yellowCursorAppears =  SETTINGS.trigger.PreWagering_yellowCursorAppears;
    trigger.Confirmation_appears =  SETTINGS.trigger.PreWagering_Confirmation_appears;
elseif dyn_wager.Wagering == 2
    trigger.yellowCursorAppears  = SETTINGS.trigger.PostWagering_yellowCursorAppears;
    trigger.Confirmation_appears = SETTINGS.trigger.PostWagering_Confirmation_appears;
elseif dyn_wager.Wagering == 0
    trigger.yellowCursorAppears  = SETTINGS.trigger.ControlWagering_yellowCursorAppears;
    trigger.Confirmation_appears = SETTINGS.trigger.ControlWagering_Confirmation_appears;
end
eye_position_changed                = 0;
wager_control_completed             = 0;
Wager_number_yellow                 = ig_randsample(1:SETTINGS.NrOfWagersCategories, 1, true, repmat(100/SETTINGS.NrOfWagersCategories,1,SETTINGS.NrOfWagersCategories) )*10;
grey_a=1;
%SETTINGS.gray_rectangular= {SETTINGS.gray_wager_color, SETTINGS.gray_wager_color/3};
switch SETTINGS.Wager_PresentedOntheScreen
    case 'RightToLeft'
        if get_hands_state == SETTINGS.no_button
            [SETTINGS.unsuccess]=Failure(5);
        elseif get_hands_state == SETTINGS.right_button
            rectangular_side = 3;
            decision_left= -1;
            grey_a=2;
            %grey_b=1;
            Wager_time_decided = GetSecs;
            Wager_time_1streleasedButton = GetSecs;
        elseif get_hands_state == SETTINGS.left_button
            rectangular_side = 0;
            decision_left= 1;
            grey_a=1;
            %grey_b=2;
            Wager_time_decided = GetSecs;

            Wager_time_1streleasedButton = GetSecs;
        end
        
        if decision_left == -1 && dyn_wager.instructed_cue_left == 1
            [SETTINGS.unsuccess]= Failure(8);
        elseif decision_left == 1 && dyn_wager.instructed_cue_left == -1
            [SETTINGS.unsuccess]= Failure(8);
        end
        
        if Wager_number_yellow == 1
            amount_rectangular=1+rectangular_side;
        elseif Wager_number_yellow == 2
            amount_rectangular=2+rectangular_side;
        else
            amount_rectangular=3+rectangular_side;
        end
    case 'UpToDown'
        amount_rectangular = Wager_number_yellow;
        if  get_hands_state == SETTINGS.no_button
            Wager_time_decided = GetSecs;
        end
end % send case or RightToLeft

% a frame around appears as cursor if the first time the button is released
color = SETTINGS.yellow_color;
frame = 1; % not filled
wagering_graphic(grey_a,amount_rectangular,frame,color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2)
if SETTINGS.doECG == 1; SendSignal(trigger.yellowCursorAppears);
    WaitSecs(0.001); %time until the screen is updated
end
if SETTINGS.doECG == 1; SendSignal(SETTINGS.trigger.off);         end
Wager_time_yellowCursor_appears = GetSecs;
button_release = 1;
StepUP = NaN;
WagerConfirmationAppeared = 0;

triggerTime = 0.1; triggerOn = 0; off = 0; SendButtonPress = 0;

while 1
    
    % pressend up or down to move the cursor
    if  get_hands_state == SETTINGS.rest_buttons || get_hands_state == SETTINGS.UP_buttons
        if get_hands_state == SETTINGS.UP_buttons && button_release
            StepUP = 1;
            Wager_time_ButtonPressUP(length(Wager_time_ButtonPressUP)+1) = GetSecs;
            Wager_time_ButtonPress(length(Wager_time_ButtonPress)+1) = GetSecs;
        elseif get_hands_state == SETTINGS.rest_buttons && button_release
            StepUP = 0;
            Wager_time_ButtonPressDOWN(length(Wager_time_ButtonPressDOWN)+1) = GetSecs;
            Wager_time_ButtonPress(length(Wager_time_ButtonPress)+1) = GetSecs;
        end
        button_release = 0;

    end
    if ~isempty(Wager_time_ButtonPress) && get_hands_state ~= SETTINGS.no_button  && ~SETTINGS.unsuccess && button_release == 0 && GetSecs - Wager_time_ButtonPress(length(Wager_time_ButtonPress)) > SETTINGS.Time_ChangetoSpeedyCursor
        while 1
            if  StepUP == 1
                amount_rectangular= amount_rectangular+2;
                if amount_rectangular == SETTINGS.NrOfWagers +1
                    amount_rectangular = 1;
                end
                
                frame=1;
                wagering_graphic(grey_a,amount_rectangular,frame,SETTINGS.yellow_color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2)
            elseif StepUP == 0
                amount_rectangular= amount_rectangular-2;
                if amount_rectangular == 0
                    amount_rectangular = SETTINGS.NrOfWagers ;
                end
                frame=1;
                wagering_graphic(grey_a,amount_rectangular,frame,SETTINGS.yellow_color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2 )
            end
            if get_hands_state == SETTINGS.no_button
                Amount_clicks= Amount_clicks+1;                Wager_time_decided = GetSecs;
                break
            end
        end
    end
    
    % released again the choosen botton then the  cursor
    if get_hands_state == SETTINGS.no_button  && StepUP == 1 && ~SETTINGS.unsuccess && button_release == 0
        amount_rectangular= amount_rectangular+1;SendButtonPress = 0;
        if amount_rectangular == SETTINGS.NrOfWagers +1
            amount_rectangular = 1;
        end
        button_release = 1;
        frame=1;
        color=SETTINGS.yellow_color;
        wagering_graphic(grey_a,amount_rectangular,frame,color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2)
        Wager_time_decided = GetSecs;
        Amount_clicks= Amount_clicks+1;
    end
    
    
    %if the down-button is released again it goes ones step down
    if get_hands_state == SETTINGS.no_button  && StepUP == 0 && ~SETTINGS.unsuccess && button_release == 0
        amount_rectangular= amount_rectangular-1;SendButtonPress = 0;
        if amount_rectangular == 0
            amount_rectangular = SETTINGS.NrOfWagers ;
        end
        button_release = 1;
        frame=1;
        color=SETTINGS.yellow_color;
        wagering_graphic(grey_a,amount_rectangular,frame,color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2 )
        Wager_time_decided = GetSecs;
        Amount_clicks= Amount_clicks+1;
    end
    %% first time choice -> recognise this
    if Amount_clicks ==1
        Wager_time_decided_first_click = GetSecs;
    end
    
    
    %%
    if SETTINGS.doECG == 1 && GetSecs - triggerTime > 0.001 && (triggerOn == 1 || triggerOn == 0 )
        TriggerNr = NaN;
        if  ~triggerOn  && StepUP == 1   && button_release == 0 && SendButtonPress  == 0
            TriggerNr = SETTINGS.trigger.ButtonUp;  triggerOn = 1; off= 1;SendButtonPress = 1;
            SendSignal(TriggerNr);            triggerTime = GetSecs;
        elseif ~triggerOn && StepUP == 0   && button_release == 0 && SendButtonPress  == 0
            TriggerNr = SETTINGS.trigger.ButtonDown;  triggerOn = 1; off= 1; SendButtonPress = 1;
            SendSignal(TriggerNr);            triggerTime = GetSecs;
        elseif triggerOn && off
            TriggerNr = SETTINGS.trigger.off;
            triggerOn = 0;
            off = 0;
            SendSignal(TriggerNr); triggerTime = GetSecs;
        end
    end
    
    % if the hand is not moved again the option is registered
    if ~isempty(Wager_time_ButtonPress) && get_hands_state == SETTINGS.no_button  && button_release == 1 && GetSecs - Wager_time_ButtonPress(length(Wager_time_ButtonPress)) > SETTINGS.Time_NoCursorMovement   && WagerConfirmationAppeared == 0
        %GetSecs - Wager_start_time >= SETTINGS.allowed_wager_time && WagerConfirmationAppeared == 0%Wagertime is expired
        if WagerConfirmationAppeared == 0; triggerOn = 0; triggerTime = 0.1;  end
        color = SETTINGS.green_color;
        frame = 1; % not filled
        WagerConfirmationAppeared = 1;
        wagering_graphic(grey_a,amount_rectangular,frame,color,BarsPlacement_WagersCategories, BarsPlacement_Wagers,BarsPlacement_WagersCategories2 )
        Wager_time_Confirmation_appears = GetSecs;
        
        if SETTINGS.doECG == 1 && GetSecs - triggerTime > 0.001 && (triggerOn == 1 || triggerOn == 0)
            if ~triggerOn;  TriggerNr = trigger.Confirmation_appears;  triggerOn = 1; else ;  TriggerNr = SETTINGS.trigger.off; triggerOn = 2; end
            SendSignal(TriggerNr);
            triggerTime = GetSecs;
        end
    end
    if  ~isempty(Wager_time_ButtonPress) && get_hands_state == SETTINGS.no_button  && button_release == 1 && GetSecs - Wager_time_ButtonPress(length(Wager_time_ButtonPress)) > SETTINGS.Time_NoCursorMovement + SETTINGS.present_visual_feedback
        Wager_end_time_wagering = GetSecs;
        break;
    end
end


if dyn_wager.control_condition ==0 && SETTINGS.unsuccess == 0
    if low_wager_down_right % sure to be close is on the bottom of the screen
        wager_choosen = amount_rectangular-1 ;
        value_choosen = NaN;
    elseif ~low_wager_down_right % sure to be close is on the bottom of the screen
        wager_choosen = SETTINGS.NrOfWagers -amount_rectangular;
        value_choosen = NaN;
    end
end

