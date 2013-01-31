use Test::Simple tests => 153;

use Chess::Game;

$game = Chess::Game->new();
ok( $game );
$board = $game->get_board();
ok( $board );
$piece = $board->get_piece_at("a1");
ok( ref($piece) eq 'Chess::Piece::Rook' );
ok( $piece->get_current_square() eq "a1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("b1");
ok( ref($piece) eq 'Chess::Piece::Knight' );
ok( $piece->get_current_square() eq "b1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("c1");
ok( ref($piece) eq 'Chess::Piece::Bishop' );
ok( $piece->get_current_square() eq "c1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("d1");
ok( ref($piece) eq 'Chess::Piece::Queen' );
ok( $piece->get_current_square() eq "d1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("e1");
ok( ref($piece) eq 'Chess::Piece::King' );
ok( $piece->get_current_square() eq "e1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("f1");
ok( ref($piece) eq 'Chess::Piece::Bishop' );
ok( $piece->get_current_square() eq "f1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("g1");
ok( ref($piece) eq 'Chess::Piece::Knight' );
ok( $piece->get_current_square() eq "g1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("h1");
ok( ref($piece) eq 'Chess::Piece::Rook' );
ok( $piece->get_current_square() eq "h1" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("a8");
ok( ref($piece) eq 'Chess::Piece::Rook' );
ok( $piece->get_current_square() eq "a8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("b8");
ok( ref($piece) eq 'Chess::Piece::Knight' );
ok( $piece->get_current_square() eq "b8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("c8");
ok( ref($piece) eq 'Chess::Piece::Bishop' );
ok( $piece->get_current_square() eq "c8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("d8");
ok( ref($piece) eq 'Chess::Piece::Queen' );
ok( $piece->get_current_square() eq "d8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("e8");
ok( ref($piece) eq 'Chess::Piece::King' );
ok( $piece->get_current_square() eq "e8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("f8");
ok( ref($piece) eq 'Chess::Piece::Bishop' );
ok( $piece->get_current_square() eq "f8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("g8");
ok( ref($piece) eq 'Chess::Piece::Knight' );
ok( $piece->get_current_square() eq "g8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("h8");
ok( ref($piece) eq 'Chess::Piece::Rook' );
ok( $piece->get_current_square() eq "h8" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("a2");
ok( ref($piece) eq 'Chess::Piece::Pawn' );
ok( $piece->get_current_square() eq "a2" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("h2");
ok( ref($piece) eq 'Chess::Piece::Pawn' );
ok( $piece->get_current_square() eq "h2" );
ok( $piece->get_player() eq "white" );
$piece = $board->get_piece_at("a7");
ok( ref($piece) eq 'Chess::Piece::Pawn' );
ok( $piece->get_current_square() eq "a7" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("h7");
ok( ref($piece) eq 'Chess::Piece::Pawn' );
ok( $piece->get_current_square() eq "h7" );
ok( $piece->get_player() eq "black" );
$piece = $board->get_piece_at("e2");
ok( !defined($game->take_back_move()) );
ok( $game->make_move("e2", "e4", 0) );
$piece = $board->get_piece_at("e7");
ok( $game->make_move("e7", "e5", 0) );
$clone = $game->clone();
ok( $clone );
$clone_b = $clone->get_board();
$piece = $clone_b->get_piece_at("d2");
ok( $clone->make_move("d2", "d4", 0) );
$ml1 = $game->get_movelist();
$ml2 = $clone->get_movelist();
ok( $ml1->get_last_moved() eq "black" );
ok( $ml1->get_move_num() == 1 );
ok( $ml2->get_last_moved() eq "white" );
ok( $ml2->get_move_num() == 2 );
ok( !defined($game->make_move("f7", "f5", 1)) );
ok( $game->get_message() eq "Not your turn" );
$piece = $board->get_piece_at("d2");
$move = $game->make_move("d2", "d4", 1);
ok( defined($move) );
ok( $move->get_move_num() == 2 );
ok( $move->get_piece() eq $piece );
$move = $game->make_move("f8", "b4", 1);
ok( defined($move) );
$move = $game->make_move("c2", "c4", 1);
ok( !defined($move) );
ok( $game->get_message() eq "Move leaves your king in check" );
$move = $game->make_move("c2", "c3", 1);
ok( defined($move) );
$move = $game->make_move("b7", "b6", 1);
ok( defined($move) );
$piece = $board->get_piece_at("b4");
$move = $game->make_move("c3", "b4");
ok( defined($move) );
$player = $move->get_piece()->get_player();
$movenum = $move->get_move_num();
ok( $game->get_capture($player, $movenum) eq $piece );
ok( $move->is_capture() == 1 );
ok( !defined($piece->get_current_square()) );
$move = $game->make_move("c8", "b7", 1);
ok( defined($move) );
$move = $game->make_move("d4", "d5", 1);
ok( defined($move) );
$move = $game->make_move("c7", "c5", 1);
ok( defined($move) );
$clone = $game->clone();
$move = $game->make_move("d5", "c6", 1);
$player = $move->get_piece()->get_player();
$movenum = $move->get_move_num();
$piece = $game->get_capture($player, $movenum);
ok( defined($move) );
ok( $move->is_capture() && $move->is_en_passant() );
ok( !defined($piece->get_current_square()) );
$move = $clone->make_move("f1", "b5", 1);
ok( defined($move) );
$move = $clone->make_move("g8", "f6", 1);
ok( defined($move) );
$move = $clone->make_move("d5", "c6", 1);
ok( !defined($move) );
$message = $clone->get_message();
ok( $message eq "Pawns must capture on a diagonal move" );
$move = $game->make_move("b7", "c6", 1);
ok( defined($move) );
$move = $game->make_move("f1", "b5", 1);
ok( defined($move) );
$move = $game->make_move("c6", "b5", 1);
ok( defined($move) );
$move = $game->make_move("g1", "f3", 1);
ok( defined($move) );
$move = $game->make_move("g8", "f6", 1);
ok( defined($move) );
$move = $game->make_move("e1", "g1", 1);
ok( !defined($move) );
$message = $game->get_message();
ok( $message eq "Can't castle through check" );
$move = $game->make_move("d1", "d3", 1);
ok( defined($move) );
$move = $game->make_move("f6", "e4", 1);
ok( defined($move) );
$move = $game->make_move("c1", "e3", 1);
ok( defined($move) );
$move = $game->make_move("e4", "c3", 1);
ok( defined($move) );
$move = $game->make_move("b1", "d2", 1);
ok( defined($move) );
$move = $game->make_move("c3", "e2", 1);
ok( defined($move) );
$clone = $game->clone();
$move = $clone->make_move("d3", "e2", 1);
ok( defined($move) );
$move = $clone->make_move("b8", "c6", 1);
ok( defined($move) );
$move = $clone->make_move("e1", "c1", 1);
ok( defined($move) );
ok( $move->is_long_castle() );
$clone_b = $clone->get_board();
$piece = $clone_b->get_piece_at("c1");
ok( $piece->isa('Chess::Piece::King') );
$piece = $clone_b->get_piece_at("d1");
ok( $piece->isa('Chess::Piece::Rook') );
$move = $game->make_move("a1", "b1", 1);
ok( defined($move) );
$move = $game->make_move("e2", "g1", 1);
ok( defined($move) );
$move = $game->make_move("e1", "g1", 1);
ok( !defined($move) );
$message = $game->get_message();
ok( $message eq "You can't capture while castling" );
$move = $game->make_move("e1", "c1", 1);
ok( !defined($move) );
$message = $game->get_message();
ok( $message eq "White's queenside rook has already moved" );
$move = $game->make_move("b2", "b3", 1);
ok( defined($move) );
$move = $game->make_move("g1", "f3", 1);
ok( defined($move) );
$move = $game->make_move("e1", "g1", 1);
ok( !defined($move) );
$message = $game->get_message();
ok( $message eq "Can't castle out of check" );
$move = $game->make_move("g2", "f3", 1);
ok( defined($move) );
$move = $game->make_move("e8", "g8", 1);
ok( defined($move) );
ok( $move->is_short_castle() );
$piece = $board->get_piece_at("g8");
ok( $piece->isa('Chess::Piece::King') );
$piece = $board->get_piece_at("f8");
ok( $piece->isa('Chess::Piece::Rook') );
$move = $game->make_move("d3", "f1", 1);
ok( defined($move) );
$move = $game->make_move("f7", "f5", 1);
ok( defined($move) );
$move = $game->make_move("e1", "g1", 1);
ok( !defined($move) );
$message = $game->get_message();
ok( $message eq "There are pieces between White's king and rook" );
$move = $game->take_back_move();
ok( defined($move) );
ok( $move->get_start_square() eq "f7" );
ok( $move->get_dest_square() eq "f5" );
$move = $game->make_move("g7", "g5", 1);
ok( defined($move) );
$move = $game->make_move("f1", "e2", 1);
ok( defined($move) );
$move = $game->make_move("g5", "g4", 1);
ok( defined($move) );
$move = $game->make_move("e2", "d3", 1);
ok( defined($move) );
$move = $game->make_move("g4", "g3", 1);
ok( defined($move) );
$move = $game->make_move("d3", "c4", 1);
ok( defined($move) );
$move = $game->make_move("g3", "g2", 1);
ok( defined($move) );
$move = $game->make_move("c4", "b5", 1);
ok( defined($move) );
$move = $game->make_move("g2", "g1", 1);
ok( defined($move) );
ok( $move->is_promotion() );
$game->do_promotion("queen");
ok( $move->get_promoted_to() eq "queen" );
$move = $game->take_back_move();
ok( defined($move) );
$piece = $board->get_piece_at("g2");
ok( $piece->isa('Chess::Piece::Pawn') );
$move = $game->make_move("g2", "g1", 1);
ok( defined($move) );
$game->do_promotion("queen");
ok( $game->player_in_check("white") );
$move = $game->make_move("h1", "g1", 1);
ok( defined($move) );
ok( !$game->player_in_check("white") );
