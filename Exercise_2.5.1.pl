% This Prolog program solves Exercise 2.5.1 from Avigad, Lewis, and
% van Doorn's _Logic and Proof_. Its structure parallels the statement
% of the problem. It has been tested on SWI-Prolog 7.6.3 for Microsoft
% Windows (64 bit). To solve the problem, issue the query
%   is_solution(M, V, A, W, Oldest, Youngest).

% Author: Ed Snow


%
% Predicate for solving the problem
%

is_solution(M, V, A, W, Oldest, Youngest) :-
% To solve just for the murderer, comment out the line above and
% uncomment the last line in this comment block. The query then
% reduces to
%    is_solution(M).
% is_solution(M) :-

% Variables:
%   M		= murderer
%   V		= victim
%   A		= accessory
%   W		= witness
%   Oldest	= oldest member
%   Youngest	= youngest member

    % Clue 1
    opposite_sex(A, W),		% This implicitly guarantees that A and W
				% bind to distinct constants.

    % Clue 2
    opposite_sex(Oldest, W),
    could_be_oldest(Oldest),

    % Clue 3
    opposite_sex(Youngest, V),
    could_be_youngest(Youngest),

    % Clue 4
    older(A, V, Oldest, Youngest),

    % Clue 5
    same(Oldest, father),

    % Clue 6
    different(Youngest, M),

    % Implicit constraints
    different(M, V),
    different(M, A),
    different(M, W),
    different(V, A),
    different(V, W).
%   different(A, W)		% Redundant. See Clue 1.

%
% Predicates for sex
%

opposite_sex(X, Y) :- male(X), female(Y).
opposite_sex(X, Y) :- female(X), male(Y).

male(father).
male(son).

female(mother).
female(daughter).

%
% Predicates for age
%

could_be_oldest(father).
could_be_oldest(mother).

could_be_youngest(son).
could_be_youngest(daughter).

older(Oldest, Y, Oldest, Youngest) :- !.	% The cuts prevent older from
older(X, Youngest, Oldest, Youngest) :- !.	% succeeding more than once
older(father, son, Oldest, Youngest).		% with the same solution.
older(father, daughter, Oldest, Youngest).
older(mother, son, Oldest, Youngest).
older(mother, daughter, Oldest, Youngest).

%
% Predicates for identity
%

member(father).
member(mother).
member(son).
member(daughter).

same(X, X).

different(X, Y) :- member(X), member(Y), +\ same(X, Y).
