function[relativePositionX, relativePositionY] = positioning(amountRows, amountColumns, HeightToPlace, WidthToPlace, inBetweenSpace, WidthObject, HeightObject, fixationPoint)

relativePositionY = zeros(amountRows,1);
relativePositionX = zeros(amountColumns,1);
distance_from_width_edge = WidthToPlace/(amountColumns*2);
% distance_from_height_edge = HeightToPlace/(amountRows*2);

if fixationPoint
    
    coordinate_fix_point = [int32(WidthToPlace/2) int32(HeightToPlace/2)];
    %     relativePositionY(1) = int32(distance_from_height_edge);
    
    if amountRows > 1
        
        if int32((amountRows/2)*(HeightObject) + (amountRows/2 - 1)*(inBetweenSpace) + inBetweenSpace/2) < coordinate_fix_point(2)
            
            if rem(amountRows,2) == 0
                
                for i = 1:amountRows/2 - 1
                    relativePositionY(i) = coordinate_fix_point(2) + (amountRows/2 - i)*(HeightObject + inBetweenSpace) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                    relativePositionY(amountRows + 1 - i) = coordinate_fix_point(2) - (amountRows/2 - i)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                    
                end
                
                relativePositionY(amountRows/2) = coordinate_fix_point(2) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                relativePositionY(amountRows/2 + 1) = coordinate_fix_point(2) - int32(HeightObject/2) - int32(inBetweenSpace/2);
            else
                for i = 1:(amountRows-1)/2 - 1
                    relativePositionY(i) = coordinate_fix_point(2) + ((amountRows-1)/2 - i)*(HeightObject + inBetweenSpace) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                    relativePositionY(amountRows - i) = coordinate_fix_point(2) - ((amountRows-1)/2 - i)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                    
                end
                
                relativePositionY((amountRows-1)/2) = coordinate_fix_point(2) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                relativePositionY((amountRows-1)/2 + 1) = coordinate_fix_point(2) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                relativePositionY(amountRows) = coordinate_fix_point(2) - ((amountRows - 1)/2)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                
            end
            
        end
        
        
        
    end
    
    if amountColumns > 1
        %         for i = 2: amountColumns
        %             relativePositionX(i) = int32(relativePositionX(i-1) + inBetween_width);
        %         end
    else
        relativePositionX(1) = int32(distance_from_width_edge);
    end
else
    if amountRows > 1
        coordinate_fix_point = [int32(WidthToPlace/2) int32(HeightToPlace/2)];
        if rem(amountRows,2) == 0
            %                  relativePositionY(1) = coordinate_fix_point(2) + ((amountRows* (HeightObject + inBetweenSpace))/2);
            %
            %                 for i =  2: (amountRows )
            %                     relativePositionY(i) =  relativePositionY(i-1) -HeightObject;
            %                 end
            for i = 1:amountRows/2 - 1
                relativePositionY(i)        = coordinate_fix_point(2)-1 + (amountRows/2 - i)*(HeightObject + inBetweenSpace) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                relativePositionY(amountRows + 1 - i) = coordinate_fix_point(2)  - (amountRows/2 - i)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                
            end
            relativePositionY(amountRows/2)      = coordinate_fix_point(2) + int32(HeightObject/2) + int32(inBetweenSpace/2);
            relativePositionY(amountRows/2 + 1)  = coordinate_fix_point(2) - int32(HeightObject/2) - int32(inBetweenSpace/2);
            relativePositionY(amountRows) =  relativePositionY(amountRows)+1;

        else
            
            for i = 1:(amountRows-1)/2 - 1
                relativePositionY(i)              = coordinate_fix_point(2)-1 + ((amountRows-1)/2 - i)*(HeightObject + inBetweenSpace) + int32(HeightObject/2) + int32(inBetweenSpace/2);
                relativePositionY(amountRows - i) = coordinate_fix_point(2) - ((amountRows-1)/2 - i)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
                
            end
            
            relativePositionY((amountRows-1)/2) = coordinate_fix_point(2)-1 + int32(HeightObject/2) + int32(inBetweenSpace/2);
            relativePositionY((amountRows-1)/2 + 1) = coordinate_fix_point(2) - int32(HeightObject/2) - int32(inBetweenSpace/2);
            %the last unqual row
            relativePositionY(amountRows) = coordinate_fix_point(2) - ((amountRows - 1)/2)*(HeightObject + inBetweenSpace) - int32(HeightObject/2) - int32(inBetweenSpace/2);
            
        end
    end
    if amountColumns > 1
        %         for i = 2: amountColumns
        %             relativePositionX(i) = int32(relativePositionX(i-1) + inBetween_width);
        %         end
    else
        relativePositionX(1) = int32(distance_from_width_edge);
    end
    
                %               relativePositionY(1) = coordinate_fix_point(2) + ((amountRows* (HeightObject + inBetweenSpace))/2);
            %               for i =  2: (amountRows )
            %                     relativePositionY(i) =  relativePositionY(i-1) -HeightObject;
            %                 end
end