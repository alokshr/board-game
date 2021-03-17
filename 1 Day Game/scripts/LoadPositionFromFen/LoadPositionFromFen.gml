// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LoadPositionFromFen(fen) {
	
	var row = 0;
	var column = 0;
	var i = 1;
	
	repeat(string_length(fen)) {
		var symbol = string_char_at(fen, i);
		
		if (symbol == "/") {
			column = 0
			row++;
			
		} else {
			
			if (IsNumber(symbol)) {
				column += real(symbol);
			} else {
				var pieceColor = symbol == string_upper(symbol) ? color.black : color.white; 
				var pieceType = pieceTypeFromSymbol[? string_lower(symbol)];
				
				board[# column, row] = [pieceType, pieceColor];
				column++;
			}	
		}
		
		if (column > w) {
			show_message("FEN notation error: column out of bounds.");
			game_end()
			break;
		}
			
		if (row >= h) {
			show_message("FEN notation error: row out of bounds.");
			game_end()
			break;
		}
		i++;
	}
}