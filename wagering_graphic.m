function wagering_graphic(grey_a,amount_rectangular,frame,color, positionsCategories,positions,positionsCategories2)
global SETTINGS
global dyn_wager
t = text(1000,1000,'test');
tCat = text(1000,1000,'test');

%% gray reactangle
for i = 1:SETTINGS.NrOfWagersCategories
   % Screen('FillRect', SETTINGS.window, SETTINGS.gray_rectangular{grey_a}, positionsCategories{i});
    t(i) = text(100,100,cell2mat(dyn_wager.wager_Text(i)));
end

for i = 1:SETTINGS.NrOfWagersCategories/3
    %Screen('FillRect', SETTINGS.window, SETTINGS.gray_rectangular{grey_a}, positionsCategories2{i});
    tCat(i) = text(100,100,cell2mat(dyn_wager.wager_Text_Category(i)));
end
for i = 1: SETTINGS.NrOfWagers
    Screen('FillRect', SETTINGS.window, SETTINGS.gray_rectangular{grey_a}, positions{i});
end
% color & position of the cursor
if frame ==1 % show just the frame
    Screen('FrameRect', SETTINGS.window, color, positions{amount_rectangular}, SETTINGS.WageringFrame_hight_pix);
elseif frame == 2 % show the filled rectangular
    Screen('FillRect', SETTINGS.window, color, positions{amount_rectangular},SETTINGS.WageringSquare_rectangular_hight);
end
if dyn_wager.control_condition
    Screen('FrameRect', SETTINGS.window, SETTINGS.blue_color, positions{dyn_wager.instructed_cue}, SETTINGS.WageringFrame_hight_pix);
end

%% adding the text
hold on
centered = zeros(SETTINGS.NrOfWagersCategories,1);
factor = zeros(SETTINGS.NrOfWagersCategories,1);
centered(1) = 1;
for i = 1:SETTINGS.NrOfWagersCategories
    Screen('TextSize', SETTINGS.window,  SETTINGS.size_text_wagering);
    if i <= SETTINGS.NrOfWagersCategories - 1
        centered(i + 1) = t(i + 1).Extent(3)/(t(1).Extent(3));
    end 
    factor(i) = ((SETTINGS.Wagering_rectangular_width/3)*(1 - centered(i)));
    Screen('DrawText', SETTINGS.window, cell2mat(dyn_wager.wager_Text(i)), dyn_wager.PositionX_wager_Text2 + factor(i), dyn_wager.PositionY_WagerCategories(i),SETTINGS.white_color);
end

centered = zeros(SETTINGS.NrOfWagersCategories/3,1);
factor = zeros(SETTINGS.NrOfWagersCategories/3,1);
% centered(1) = 1;
for i = 1:SETTINGS.NrOfWagersCategories/3
    Screen('TextSize', SETTINGS.window,  SETTINGS.size_text_wagering);
    if i <= (SETTINGS.NrOfWagersCategories/3)-1
        centered(i + 1) = t(i + 1).Extent(3)/(t(1).Extent(3));

    end 
    factor(i) = ((SETTINGS.Wagering_rectangular_width/3)*(1 - centered(i)));

    Screen('DrawText', SETTINGS.window, cell2mat(dyn_wager.wager_Text_Category(i)), dyn_wager.PositionX_wager_Text3+ factor(i) , dyn_wager.PositionY_WagerCategories2(i),SETTINGS.white_color);
end

Screen(SETTINGS.window,'Flip');
end