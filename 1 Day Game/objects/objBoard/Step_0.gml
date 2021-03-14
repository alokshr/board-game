// Mouse position
mouseX = mouse_x - x + xoffset;
mouseY = mouse_y - y + yoffset;
mouseCellX = mouseX div cellSize;
mouseCellY = mouseY div cellSize;

mouseIn = point_in_rectangle(mouseX, mouseY, 0, 0, w*cellSize, h*cellSize);

var mousePress = mouse_check_button_pressed(mb_left);

// Press
if (mouseIn && mousePress){
    
	// State 0 (Nothing selected)
    if (state == 0) {
		
        var arr = board[# mouseCellX, mouseCellY]; // Get array
       
        if (is_array(arr)){ // If the cell contains something, do something
            
			//Get info
            var aPiece = arr[ar.piece];
            var aTeam = arr[ar.team];
       
            //Accept
            if (aTeam == turn) {
                //Save selected cell
                selectedX = mouseCellX;
                selectedY = mouseCellY;
                selectedPiece = aPiece;
               
                // State
                state = 1;
            }
        }
    }
    // State 1 (Something selected)
	else if (state == 1) {
		
        // Get array
        var arr = board[# mouseCellX, mouseCellY];
	   
        // Check for selected piece and assign behaviors
		pieceBehavior(selectedPiece);
		
        if (arr == 0) {
			
            // Empty selected cell
            board[# selectedX, selectedY] = 0;
           
            // Move to new place
            board[# mouseCellX, mouseCellY] = [selectedPiece, turn];
           
            // State
            state = 0;
           
            // Turn
            turn = !turn;
           
            // Reset selected
            selectedX = -1;
            selectedY = -1;
            selectedPiece = -1;
        }
    }
}

// Canceling
if (mouse_check_button_pressed(mb_right) && state==1){
    state = 0;
   
    selectedX = -1;
    selectedY = -1;
    selectedPiece = -1;
}