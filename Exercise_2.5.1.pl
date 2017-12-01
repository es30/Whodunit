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
    parent(Oldest),		% Only a parent can be the oldest.

    % Clue 3
    opposite_sex(Youngest, V),
    child(Youngest),		% Only a child can be the youngest.

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
% Predicate for age
% older(X, Y, Oldest, Youngest) succeeds if X is older than Y.
%

older(X, Y, _, _) :- parent(X), child(Y).
older(X, Y, X, _) :- parent(X), parent(Y), different(X, Y).
older(X, Y, _, Y) :- child(X),  child(Y),  different(X, Y).

%
% Predicates for identity
%

same(X, X).

different(X, Y) :- member(X), member(Y), \+ same(X, Y).

member(X) :- parent(X).
member(X) :- child(X).

parent(father).
parent(mother).

child(son).
child(daughter).
