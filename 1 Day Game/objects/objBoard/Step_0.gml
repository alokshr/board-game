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
		
        var arr = board[# mouseCellX, mouseCellY]; // Get clicked cell array
	   
        if (is_array(arr)){ // If the cell contains something, select it
			
			var aPiece = arr[ar.piece];
			var aTeam = arr[ar.team];
			
            // Select only selectable pieces
			if (aPiece != piece.castle && aPiece != piece.skull && aPiece != piece.mine) {
				// Check if it's the right turn
				if (aTeam == turn) { 
				
		            //Save selected cell
		            selectedX = mouseCellX;
		            selectedY = mouseCellY;
		            selectedPiece = aPiece;
					selectedPieceTeam = aTeam;
               
		            // State
		            state = 1;
				}
			}
        }
    }
    // State 1 (Something selected)
	else if (state == 1) {
        // Check for selected piece and assign behaviors
		PieceBehavior(selectedPiece);
    }
}

// Canceling
if (mouse_check_button_pressed(mb_right) && state==1){
    state = 0;
   
    selectedX = -1;
    selectedY = -1;
    selectedPiece = -1;
}