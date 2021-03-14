// Board
cellSize = 64;
w = 8;
h = 8;

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
    road,
    castle,
    skull
}

// Color
enum color {
	white,
	black
}

pieceSprite[piece.road] = sprRoad;
pieceSprite[piece.castle] = sprCastle;
pieceSprite[piece.skull] = sprSkull;


pieceTypeFromSymbol = ds_map_create();
	
ds_map_add(pieceTypeFromSymbol, "s", piece.skull);
ds_map_add(pieceTypeFromSymbol, "r", piece.road);
ds_map_add(pieceTypeFromSymbol, "c", piece.castle);

// Place pieces
//Lowercase = white, uppercase = black
//Position starts from top-left
startPosition = "c1s2s1c///////C1S2S1C"

LoadPositionFromFen(startPosition)

function pieceBehavior(piece) {
	switch (piece) {
		case piece.skull: break;
		case piece.castle: break;
		case piece.road: break;
		default: break;
	}
}