#!/usr/bin/perl

use Tkx;
use Chess::Game;

$, = " ";
$\ = "\n";

sub findmoves {
	my $game = shift;
	my @moves;
	for my $piece (@{$game->get_pieces()}) {

		for my $square ($piece->reachable_squares()) {

			if ($game->is_move_legal($piece->get_current_square(), $square)) {
				push @moves, join ' ', $piece->get_current_square(), $square;
				print join ' ', $piece->get_current_square(), $square;
			}
		}

	}

	return @moves;
}

sub evaluate {

	my $game = shift;
	my $points = 0;

	for my $piece (@{$game->get_pieces()}) {

		if (ref($piece) eq "Chess::Piece::Pawn" and not $piece->captured()) {

			$points += 1;

		}

		elsif (ref($piece) eq "Chess::Piece::Rook" and not $piece->captured()) {

			$points += 5;

		}

		elsif (ref($piece) eq "Chess::Piece::Knight" and not $piece->captured()) {

			$points += 3.5;

		}

		elsif (ref($piece) eq "Chess::Piece::Bishop" and not $piece->captured()) {

			$points += 3.5;

		}

		elsif (ref($piece) eq "Chess::Piece::Queen" and not $piece->captured()) {

			$points += 10;

		}

		elsif (ref($piece) eq "Chess::Piece::King") {

			$points += 100;

		}
	}

	return $points;
}

sub apply {

	my $game = shift;
	my $move = shift;
	my ($move_from, $move_to) = split ' ', $move;
	$game->make_move($move_from, $move_to);

	return $game;

}

sub computer_move {
	
	my $game = shift;
	my @moves;
	my $board = $game->get_board();

	for my $piece (@{$game->get_pieces()}) {

		for my $square ($piece->reachable_squares()) {

			if ($game->is_move_legal($piece->get_current_square(), $square)) {
				if(defined($board->get_piece_at($square))) {
					return join ' ', $piece->get_current_square(), $square;
				}
				push @moves, join ' ', $piece->get_current_square(), $square;
			}

		}

	}

	return $moves[0];

}

my ($game, $lastx, $lasty, $count);

$game = Chess::Game->new();
$count = 0;

my %coords;

my $mw = Tkx::widget->new(".");
$mw->g_wm_title("My chess");

my $canvas = $mw->new_tk__canvas(-width => 500, -height => 500);
$canvas->g_grid(-column=>0, -row=>0, -sticky=>"nwes");
$mw->g_grid_columnconfigure(0, -weight=>1);
$mw->g_grid_rowconfigure(0, -weight=>1);

$canvas->g_bind("<1>", [sub {my ($x,$y) = @_; $lastx=25 + $x - $x % 50; $lasty=25 + $y - $y % 50;}, Tkx::Ev("%x","%y")]);
$canvas->g_bind("<ButtonRelease-1>", [sub {my ($x, $y) = @_; check_place($x, $y)}, Tkx::Ev("%x", "%y")]);

for(my $i = 1; $i < 9; $i+=1) {

	for(my $j = 1; $j < 9; $j+=1) {

		if(($i + $j) % 2) {
			$canvas->create_rectangle(50 * $i, 50 * $j, 50 + 50 * $i, 50 + 50 * $j, -fill => "#8b4513");
		}

		else {
			$canvas->create_rectangle(50 * $i, 50 * $j, 50 + 50 * $i, 50 + 50 * $j, -fill => "#eedd82");
		}

	}

}

Tkx::image_create_photo("black_rook1", -file => "rook_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_knight1", -file => "horse_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_bishop1", -file => "bishop_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_king", -file => "king_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_queen", -file => "queen_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_bishop2", -file => "bishop_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_knight2", -file => "horse_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_rook2", -file => "rook_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn1", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn2", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn3", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn4", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn5", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn6", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn7", -file => "pawn_b.gif", -width => 45, -height => 45);
Tkx::image_create_photo("black_pawn8", -file => "pawn_b.gif", -width => 45, -height => 45);

$canvas->create_image(75, 75, -anchor => "center", -image => "black_rook1", -tag => "rook_b1");
$canvas->create_image(125, 75, -anchor => "center", -image => "black_knight1", -tag => "knight_b1");
$canvas->create_image(175, 75, -anchor => "center", -image => "black_bishop1", -tag => "bishop_b1");
$canvas->create_image(275, 75, -anchor => "center", -image => "black_king", -tag => "king_b");
$canvas->create_image(225, 75, -anchor => "center", -image => "black_queen", -tag => "queen_b");
$canvas->create_image(325, 75, -anchor => "center", -image => "black_bishop2", -tag => "bishop_b2");
$canvas->create_image(375, 75, -anchor => "center", -image => "black_knight2", -tag => "knight_b2");
$canvas->create_image(425, 75, -anchor => "center", -image => "black_rook2", -tag => "rook_b2");
$canvas->create_image(75, 125, -anchor => "center", -image => "black_pawn1", -tag => "pawn_b1");
$canvas->create_image(125, 125, -anchor => "center", -image => "black_pawn2", -tag => "pawn_b2");
$canvas->create_image(175, 125, -anchor => "center", -image => "black_pawn3", -tag => "pawn_b3");
$canvas->create_image(225, 125, -anchor => "center", -image => "black_pawn4", -tag => "pawn_b4");
$canvas->create_image(275, 125, -anchor => "center", -image => "black_pawn5", -tag => "pawn_b5");
$canvas->create_image(325, 125, -anchor => "center", -image => "black_pawn6", -tag => "pawn_b6");
$canvas->create_image(375, 125, -anchor => "center", -image => "black_pawn7", -tag => "pawn_b7");
$canvas->create_image(425, 125, -anchor => "center", -image => "black_pawn8", -tag => "pawn_b8");

$coords{"75 75"} = "rook_b1";
$coords{"125 75"} = "knight_b1";
$coords{"175 75"} = "bishop_b1";
$coords{"275 75"} = "king_b";
$coords{"225 75"} = "queen_b";
$coords{"325 75"} = "bishop_b2";
$coords{"375 75"} = "knight_b2";
$coords{"425 75"} = "rook_b2";
$coords{"75 125"} = "pawn_b1";
$coords{"125 125"} = "pawn_b2";
$coords{"175 125"} = "pawn_b3";
$coords{"225 125"} = "pawn_b4";
$coords{"275 125"} = "pawn_b5";
$coords{"325 125"} = "pawn_b6";
$coords{"375 125"} = "pawn_b7";
$coords{"425 125"} = "pawn_b8";

Tkx::image_create_photo("white_rook1", -file => "rook_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_knight1", -file => "horse_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_bishop1", -file => "bishop_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_king", -file => "king_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_queen", -file => "queen_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_bishop2", -file => "bishop_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_knight2", -file => "horse_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_rook2", -file => "rook_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn1", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn2", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn3", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn4", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn5", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn6", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn7", -file => "pawn_w.gif", -width => 45, -height => 45);
Tkx::image_create_photo("white_pawn8", -file => "pawn_w.gif", -width => 45, -height => 45);

$canvas->create_image(75, 425, -anchor => "center", -image => "white_rook1", -tag => "rook_w1");
$canvas->create_image(125, 425, -anchor => "center", -image => "white_knight1", -tag => "knight_w1");
$canvas->create_image(175, 425, -anchor => "center", -image => "white_bishop1", -tag => "bishop_w1");
$canvas->create_image(275, 425, -anchor => "center", -image => "white_king", -tag => "king_w");
$canvas->create_image(225, 425, -anchor => "center", -image => "white_queen", -tag => "queen_w");
$canvas->create_image(325, 425, -anchor => "center", -image => "white_bishop2", -tag => "bishop_w2");
$canvas->create_image(375, 425, -anchor => "center", -image => "white_knight2", -tag => "knight_w2");
$canvas->create_image(425, 425, -anchor => "center", -image => "white_rook2", -tag => "rook_w2");
$canvas->create_image(75, 375, -anchor => "center", -image => "white_pawn1", -tag => "pawn_w1");
$canvas->create_image(125, 375, -anchor => "center", -image => "white_pawn2", -tag => "pawn_w2");
$canvas->create_image(175, 375, -anchor => "center", -image => "white_pawn3", -tag => "pawn_w3");
$canvas->create_image(225, 375, -anchor => "center", -image => "white_pawn4", -tag => "pawn_w4");
$canvas->create_image(275, 375, -anchor => "center", -image => "white_pawn5", -tag => "pawn_w5");
$canvas->create_image(325, 375, -anchor => "center", -image => "white_pawn6", -tag => "pawn_w6");
$canvas->create_image(375, 375, -anchor => "center", -image => "white_pawn7", -tag => "pawn_w7");
$canvas->create_image(425, 375, -anchor => "center", -image => "white_pawn8", -tag => "pawn_w8");

$coords{"75 425"} = "rook_w1";
$coords{"125 425"} = "knight_w1";
$coords{"175 425"} = "bishop_w1";
$coords{"275 425"} = "king_w";
$coords{"225 425"} = "queen_w";
$coords{"325 425"} = "bishop_w2";
$coords{"375 425"} = "knight_w2";
$coords{"425 425"} = "rook_w2";
$coords{"75 375"} = "pawn_w1";
$coords{"125 375"} = "pawn_w2";
$coords{"175 375"} = "pawn_w3";
$coords{"225 375"} = "pawn_w4";
$coords{"275 375"} = "pawn_w5";
$coords{"325 375"} = "pawn_w6";
$coords{"375 375"} = "pawn_w7";
$coords{"425 375"} = "pawn_w8";

my $message = "White's are first";
my $em = $mw->new_ttk__label(-textvariable => \$message);
$em->g_grid(-column => 0, -row => 1, -sticky => "we");

my %coords_to_square = (
	"75 75", "a8", "125 75", "b8", "175 75", "c8", "225 75", "d8", "275 75", "e8", "325 75", "f8", "375 75", "g8", "425 75", "h8",
	"75 125", "a7", "125 125", "b7", "175 125", "c7", "225 125", "d7", "275 125", "e7", "325 125", "f7", "375 125", "g7", "425 125", "h7",
	"75 175", "a6", "125 175", "b6", "175 175", "c6", "225 175", "d6", "275 175", "e6", "325 175", "f6", "375 175", "g6", "425 175", "h6",
	"75 225", "a5", "125 225", "b5", "175 225", "c5", "225 225", "d5", "275 225", "e5", "325 225", "f5", "375 225", "g5", "425 225", "h5",
	"75 275", "a4", "125 275", "b4", "175 275", "c4", "225 275", "d4", "275 275", "e4", "325 275", "f4", "375 275", "g4", "425 275", "h4",
	"75 325", "a3", "125 325", "b3", "175 325", "c3", "225 325", "d3", "275 325", "e3", "325 325", "f3", "375 325", "g3", "425 325", "h3",
	"75 375", "a2", "125 375", "b2", "175 375", "c2", "225 375", "d2", "275 375", "e2", "325 375", "f2", "375 375", "g2", "425 375", "h2",
	"75 425", "a1", "125 425", "b1", "175 425", "c1", "225 425", "d1", "275 425", "e1", "325 425", "f1", "375 425", "g1", "425 425", "h1",
);

my %square_to_coords;

while ((my $coords, my $square) = each %coords_to_square) {
	$square_to_coords{$square} = $coords;
}

sub check_place {

	my ($x, $y) = @_;
	$x = 25 + $x - $x % 50;
	$y = 25 + $y - $y % 50;
	my $figure = $coords{join ' ', $lastx, $lasty};

	if($x > 450 or $x <50 or $y > 450 or $y < 50) {

		$canvas->coords($figure, $lastx, $lasty);
		return;

	}

	if(not $game->is_move_legal($coords_to_square{join ' ', $lastx, $lasty}, $coords_to_square{join ' ', $x, $y})) {

		$canvas->coords($figure, $lastx, $lasty);
		$message = $game->get_message();
		return;

	}

	$game->make_move($coords_to_square{join ' ', $lastx, $lasty}, $coords_to_square{join ' ', $x, $y});

#castle
	if($figure =~ /king/ and abs ($x - $lastx) == 100) {

		if($x == 375 and $y == 425) {
			$canvas->coords("rook_w2", 325, 425);
		}

		elsif($x == 175 and $y == 425) {
			$canvas->coords("rook_w1", 225, 425);
		}

		elsif($x == 375 and $y == 75) {
			$canvas->coords("rook_b2", 325, 75);
		}

		elsif($x == 175 and $y == 75) {
			$canvas->coords("rook_b1", 225, 75);
		}

	}

#en_passan
	if(($lastx != $x) and ($figure =~ /pawn/) and ($coords{join ' ', $x, $lasty} =~ /pawn/) and not ($coords{join ' ', $x, $y})) {

		my $captured_piece = $coords{join ' ', $x, $lasty};
		$canvas->move($captured_piece, 1000, 1000);
		$coords{join ' ', $x, $lasty} = nil;

	}

	elsif($coords{join ' ', $x, $y}) {

		my $captured_piece = $coords{join ' ', $x, $y};
		$canvas->move($captured_piece, 1000, 1000);

	}

	$canvas->move($figure, $x - $lastx, $y - $lasty);
	$coords{join ' ', $lastx, $lasty} = nil;
	$coords{join ' ', $x, $y} = $figure;

	my $result = $game->result();

	if($count % 2) {

		$message = "It's white's turn";

	}

	else {

		$message = "It's black's turn";

	}

	$count++;

	if(defined($result)) {

		if ($result == 1) {

			$result_message = "White wins!\n";

		}

		elsif ($result == 0) {

			$result_message = "Draw!\n"

		}

		elsif ($result == -1) {

			$result_message = "Black wins!\n";

		}

		$w = $mw->new_toplevel;
		$w->g_wm_title("Result");
		$result_label = $w->new_ttk__label(-textvariable => \$result_message);
		$result_label->g_grid(-column => 0, -row => 1, -sticky => "we");

	}

	$move = computer_move($game);
 	$game = apply($game, $move);

 	my ($sq1, $sq2) = split ' ', $move;
 	my ($lasta, $lastb) = split ' ', $square_to_coords{$sq1};
 	my ($a, $b) = split ' ', $square_to_coords{$sq2};

 	my $figure = $coords{join ' ', $lasta, $lastb};

	if($a > 450 or $a < 50 or $b > 450 or $b < 50) {

		$canvas->coords($figure, $lasta, $lastb);
		return;

	}

	$game->make_move($coords_to_square{join ' ', $lasta, $lastb}, $coords_to_square{join ' ', $a, $b});

#castle
	if($figure =~ /king/ and abs ($a - $lasta) == 100) {

		if($a == 375 and $b == 425) {
			$canvas->coords("rook_w2", 325, 425);
		}

		elsif($a == 175 and $b == 425) {
			$canvas->coords("rook_w1", 225, 425);
		}

		elsif($a == 375 and $b == 75) {
			$canvas->coords("rook_b2", 325, 75);
		}

		elsif($a == 175 and $b == 75) {
			$canvas->coords("rook_b1", 225, 75);
		}

	}

#en_passan
	if(($lasta != $a) and ($figure =~ /pawn/) and ($coords{join ' ', $a, $lastb} =~ /pawn/) and not ($coords{join ' ', $a, $b})) {

		my $captured_piece = $coords{join ' ', $a, $lastb};
		$canvas->move($captured_piece, 1000, 1000);
		$coords{join ' ', $a, $lastb} = nil;

	}

	elsif($coords{join ' ', $a, $b}) {

		my $captured_piece = $coords{join ' ', $a, $b};
		$canvas->move($captured_piece, 1000, 1000);

	}

	$canvas->move($figure, $a - $lasta, $b - $lastb);
	$coords{join ' ', $lasta, $lastb} = nil;
	$coords{join ' ', $a, $b} = $figure;

	my $result = $game->result();

	if($count % 2) {

		$message = "It's white's turn";

	}

	else {

		$message = "It's black's turn";

	}

	$count++;

	if(defined($result)) {

		if ($result == 1) {
			$result_message = "White wins!\n";
		}

		elsif ($result == 0) {
			$result_message = "Draw!\n"
		}

		elsif ($result == -1) {
			$result_message = "Black wins!\n";
		}

		$w = $mw->new_toplevel;
		$w->g_wm_title("Result");
		$result_label = $w->new_ttk__label(-textvariable => \$result_message);
		$result_label->g_grid(-column => 0, -row => 1, -sticky => "we");
	}
}

Tkx::MainLoop();
