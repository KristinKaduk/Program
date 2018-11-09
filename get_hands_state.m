function hand_status = get_hands_state

global SETTINGS      
        [~,~,keyCode,~] =  KbCheck; %KbCheck;
                if  find(keyCode)== 40 %find(firstPress)== 40 ||
                hand_status = SETTINGS.rest_buttons;
                elseif  find(keyCode)== 38 %find(firstPress)== 40 ||
                hand_status = SETTINGS.UP_buttons;
                elseif  find(keyCode)== 40 %find(firstPress)== 40 ||
                hand_status = SETTINGS.DOWN_buttons;
                elseif  find(keyCode)== 32 %KbName('space')
                hand_status = SETTINGS.rest_buttons;
                elseif   sum(keyCode) == 0 
                hand_status = SETTINGS.no_button;
                else
                hand_status = SETTINGS.no_button; 
                end
%         button_idx = [KbName('space') 37 38 39 40];
%         switch mat2str(keyCode(button_idx))            
%             case '[0 0 0 0 0]'
%                 hand_status = SETTINGS.no_button;
%             case '[0 0 0 0 1]'
%                 hand_status = SETTINGS.rest_buttons;
%             case '[0 0 1 0 0]' %38
%                 hand_status = SETTINGS.UP_buttons;
%             case '[0 0 0 0 1]' %40
%                 hand_status = SETTINGS.DOWN_buttons;
%             otherwise
%                 hand_status = SETTINGS.no_button;
%         end

end