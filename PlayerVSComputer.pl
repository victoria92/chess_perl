#!/usr/bin/perl -w

use strict;
use Chess::Game;
use Games::AlphaBeta;

$, = " ";
$\ = "\n";

package Chess::GamePos;
use base qw(Games::AlphaBeta::Position);

sub _init {
	shift;
	my $self = shift;
	bless $self;
	return $self;
}

sub findmoves {    #podavame igrata kato argument
	my $game = shift;
	my @moves = [];
	for my $piece (@{$game->get_pieces()}) { #trqbva da otchitame i koi e na hod!!!

		for my $square ($piece->reachable_squares()) {

			if ($game->is_move_legal($piece->get_current_square(), $square)) {
				push @moves, [$piece->get_current_square(), $square];
			}

		}

	}
	return @moves;
}

sub evaluate {
	my $game = shift;
	my $points = 0;
	#trqbva da ocenim na baza na nalichnite figuri
	for my $piece (@{$game->get_pieces()}) { #trqbva da otchitame i koi e na hod!!!

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
}

sub apply {
	my $game = shift;
	my $move = shift;
	my ($move_from, $move_to) = @$move;
	$game->make_move($move_from, $move_to);
}


package main;

my ($game, $clone, $move, $move_c, $true, $sq1, $sq2, $result);

$game = Chess::Game->new();

my $i = 0;

while (!defined($result = $game->result())) {

	if ($i % 2 == 0) {
		$a = <>;
		($sq1, $sq2) = split(' ', $a);
		$move = $game->make_move($sq1, $sq2);

		if (!defined($move)) {
			print $game->get_message();
		}
	}

	else {
		my $new = Chess::GamePos->new($game);
		my $current_game = Games::AlphaBeta->new($new);
		print $current_game->abmove();
	}

	$i++;
}

if ($result == 1) {
	print "White wins!\n";
}

elsif ($result == 0) {
	print "Draw!\n"
}

else {
	print "Black wins!\n";
}
