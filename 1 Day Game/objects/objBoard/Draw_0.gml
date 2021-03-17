//Draw board
for(var yy = 0; yy < h; yy++){
    for(var xx = 0; xx < w; xx++){
        //Cell position
        var cX = x-xoffset + xx*cellSize;
        var cY = y-yoffset + yy*cellSize;
		
		var cellDistanceX = selectedX - xx;
		var cellDistanceY = selectedY - yy;
     
        //Alpha
        var alpha = 0.2;
        if (mouseCellX == xx && mouseCellY == yy){
            alpha = 0.4;
        }
       
        //Color
        var color = c_white;
        if (selectedX == xx && selectedY == yy){
            color = c_green;
        }
       
		if (selectedPiece != -1) {
			switch (selectedPiece) {
				case piece.pawn: 
				
				if (selectedPieceTeam == color.white) {
					if (cellDistanceY >= -1 && cellDistanceY <= 0 && abs(cellDistanceX) <= 1) {
						alpha = 0.4;
					}
				} else if (cellDistanceY >= 0 && cellDistanceY <= 1 && abs(cellDistanceX) <= 1) {
					alpha = 0.4;
				}
				break;
				
				case piece.bishop:
				
				if (abs(cellDistanceY) == abs(cellDistanceX)) {
					alpha = 0.4;	
				}
				
				break;
				
				case piece.rook: 
				
				if ((cellDistanceX == 0 && cellDistanceY != 0) || (cellDistanceX != 0 && cellDistanceY == 0)) {
					alpha = 0.4;
				}	
				
				break;
			}
		}
		
        //Draw cell
        draw_set_alpha(alpha);
        draw_set_color(color);
        draw_rectangle(cX + 1, cY + 1, cX + cellSize-1, cY + cellSize-1, 0);
        draw_set_alpha(1);
        draw_set_color(c_white);
       
        //Get array
        var arr = board[# xx, yy];
       
        if (is_array(arr)){
            var aPiece = arr[ar.piece];
            var aTeam = arr[ar.team];
           
            var spr = pieceSprite[aPiece];
            var sprColor = c_white;
           
            if (aTeam == color.black)
                sprColor = c_black;
               
            draw_sprite_ext(spr, 0, cX + cellSize/2, cY + cellSize/2,
                1, 1, 0, sprColor, 1);
        }
    }
}