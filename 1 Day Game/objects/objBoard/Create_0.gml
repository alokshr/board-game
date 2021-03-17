// Board
cellSize = 64;
w = 9;
h = 9;

xoffset = (w*cellSize)/2
yoffset = (h*cellSize)/2

board = ds_grid_create(w, h);

// Vars
turn = 0;
state = 0;

selectedX = -1;
selectedY = -1;
selectedPiece = -1;

// Array contents
enum ar {
    piece,
    team
}

// Pieces
enum piece {
    castle,
	mine,
    skull,
	pawn,
	bishop,
	rook,
	queen
}

// Color
enum color {
	white,
	black
}


pieceSprite[piece.castle] = sprCastle;
pieceSprite[piece.mine] = sprMine;
pieceSprite[piece.skull] = sprSkull;
pieceSprite[piece.pawn] = sprPawn;
pieceSprite[piece.bishop] = sprBishop;
pieceSprite[piece.rook] = sprRook;

pieceTypeFromSymbol = ds_map_create();
	
ds_map_add(pieceTypeFromSymbol, "c", piece.castle);
ds_map_add(pieceTypeFromSymbol, "m", piece.mine);
ds_map_add(pieceTypeFromSymbol, "s", piece.skull);
ds_map_add(pieceTypeFromSymbol, "p", piece.pawn);
ds_map_add(pieceTypeFromSymbol, "b", piece.bishop);
ds_map_add(pieceTypeFromSymbol, "r", piece.rook);
ds_map_add(pieceTypeFromSymbol, "q", piece.queen);

// Place pieces
// Lowercase = white, uppercase = black
// Position starts from top-left
startPosition = "4c/1s/3p1p/3r1b/4m/3B1R/3P1P/7S/4C"

LoadPositionFromFen(startPosition)

function MovePiece(piece, color){
	// Empty selected cell
	board[# selectedX, selectedY] = 0;
           
	// Move to new place
	board[# mouseCellX, mouseCellY] = [piece, color];
           
	// State
	state = 0;
           
	// Turn
	turn = !turn;
           
	// Reset selected
	selectedX = -1;
	selectedY = -1;
	selectedPiece = -1;
	selectedPieceTeam = -1;
}
	
function PieceBehavior(pieceToMove) {
	// Get array
	var arr = board[# mouseCellX, mouseCellY];
	
	var pawnMove = false;
	var bishopMove = false;
	var rookMove = false;
	var queenMove = false;
	
	var cellDistanceX = selectedX - mouseCellX;
	var cellDistanceY = selectedY - mouseCellY;
	
	switch (pieceToMove) {
		case piece.pawn: pawnMove = true; break;
		case piece.bishop: bishopMove = true; break;
		case piece.rook: rookMove = true; break;
		case piece.queen: queenMove = true; break;
		default: break;
	}
	
	//Pawn Behaviour
	if (pawnMove) {
		
		switch (selectedPieceTeam) {
			case color.white:
			
			if (cellDistanceY >= -1 && cellDistanceY <= 0 && abs(cellDistanceX) <= 1) {
				if (!is_array(arr)) {
					MovePiece(pieceToMove, turn);
				} else if (arr[ar.piece] == piece.mine) {
					MovePiece(piece.skull, turn);
				} else if (arr[ar.team] != selectedPieceTeam) {
					if (arr[ar.piece] == piece.skull) {
						MovePiece(piece.mine, color.white);
					} else {
						MovePiece(pieceToMove, turn);
					}
				}
			}
			break;
		
			case color.black:
			
			if (cellDistanceY >= 0 && cellDistanceY <= 1 && abs(cellDistanceX) <= 1) {
				if (!is_array(arr)) {
					MovePiece(pieceToMove, turn);
				} else if (arr[ar.piece] == piece.mine) {
					MovePiece(piece.skull, turn);
				} else if (arr[ar.piece] == piece.skull) {
					MovePiece(piece.mine, color.white);
				} else if (arr[ar.team] != selectedPieceTeam) {
					MovePiece(pieceToMove, turn);
				}
			}
			break;
		}
	}
		
	if (bishopMove) {	
		if (abs(cellDistanceY) == abs(cellDistanceX)) {
			if (!is_array(arr)) {		
				MovePiece(pieceToMove, turn);
			} else if (arr[ar.team] != selectedPieceTeam) {
				if (arr[ar.piece] != piece.skull && arr[ar.piece] != piece.mine) {
					MovePiece(pieceToMove, turn);
				}
			}
		}
	}
	
	if (rookMove) {
		if ((cellDistanceX == 0 && cellDistanceY != 0) || (cellDistanceX != 0 && cellDistanceY == 0)) {
			if (!is_array(arr)) {		
				MovePiece(pieceToMove, turn);
			} else if (arr[ar.team] != selectedPieceTeam) {
				if (arr[ar.piece] != piece.skull && arr[ar.piece] != piece.mine) {
					MovePiece(pieceToMove, turn);
				}
			}
		}
	}
}