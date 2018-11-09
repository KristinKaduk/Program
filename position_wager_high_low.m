
function position_wager_high_low(low_wager_down_right, placement1, placement2,placement3)

global SETTINGS
global dyn_wager
% sure to be correct is presented on the top part of the scale -> highest
if low_wager_down_right == 0  %
    for  i_wag = 0: SETTINGS.NrOfWagersCategories-1
    dyn_wager.PositionY_WagerCategories(i_wag +1)= placement1{i_wag+1}(2)+SETTINGS.Wagering_rectangular_hight/(SETTINGS.NrOfWagersCategories/2);
    dyn_wager.wager_Text{i_wag +1} = SETTINGS.wager_Text{SETTINGS.NrOfWagersCategories-i_wag}; 
    end
    
    for  i_wag = 0: (SETTINGS.NrOfWagersCategories/3)-1
    dyn_wager.PositionY_WagerCategories2(i_wag +1)= placement3{i_wag+1}(2)+SETTINGS.WagersCategories2_rectangular_hight/2;
    dyn_wager.wager_Text_Category{i_wag +1} = SETTINGS.wager_Text_Category{(SETTINGS.NrOfWagersCategories/3) -i_wag}; 
    end
    
    for  i_wag = 0: SETTINGS.NrOfWagers-1
    dyn_wager.Position_wager_h(i_wag +1)= placement2{i_wag+1}(2)+SETTINGS.WageringSquare_rectangular_hight/ (SETTINGS.NrOfWagers/2);
    end
elseif low_wager_down_right      == 1 
    for i_wag = 0: SETTINGS.NrOfWagersCategories -1
    dyn_wager.PositionY_WagerCategories(i_wag+1)= placement1{SETTINGS.NrOfWagersCategories -i_wag}(2)+SETTINGS.Wagering_rectangular_hight/(SETTINGS.NrOfWagersCategories/2);
    dyn_wager.wager_Text{i_wag+1} = SETTINGS.wager_Text{SETTINGS.NrOfWagersCategories-i_wag}; 
    end
    
    for  i_wag = 0: (SETTINGS.NrOfWagersCategories/3)-1
    dyn_wager.PositionY_WagerCategories2(i_wag +1)= placement3{(SETTINGS.NrOfWagersCategories/3) -i_wag}(2)+SETTINGS.WagersCategories2_rectangular_hight/2;
    dyn_wager.wager_Text_Category{i_wag +1} = SETTINGS.wager_Text_Category{(SETTINGS.NrOfWagersCategories/3) -i_wag}; 
    end
    
    
    for i_wag = 0: SETTINGS.NrOfWagers -1
    dyn_wager.Position_wager_h(i_wag+1)= placement2{SETTINGS.NrOfWagers -i_wag}(2)+SETTINGS.WageringSquare_rectangular_hight/3;
    end

end
    %dyn_wager.Position_wager_w_Text1 = placement1{3}(1)+ 10;
    dyn_wager.PositionX_wager_Text2 = placement1{1}(1) + 10 ;%+ 55;
    dyn_wager.PositionX_wager_Text3 = placement3{1}(1) +5 ;%- 160;

