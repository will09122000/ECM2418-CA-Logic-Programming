% Checks that all 4 digits in the possible par are unique.
unique([]).
unique([X|Xs])
    :- \+ memberchk(X, Xs),
        unique(Xs).

% Split the par into 2 halves.
split(L, 0, [], L).
split([H|T], N, [H|X], L2)
    :- N > 0,
        M is N - 1,
        split(T, M, X, L2).

% Returns true if the number is a PAR.
par( X )
    :- atom_length( X,4 ),
        atom_chars( X,Y ),
        unique( Y ),
        % Check that the possible par does not contain a '0'.
        \+ member('0', Y),
        % Check that the second two digits is a factor of the first 2 digits.
        split(Y,2,A,B),
        atomic_list_concat(A, A1),
        atomic_list_concat(B, B1),
        atom_number(A1, A2),
        atom_number(B1, B2),
        0 is A2 mod B2.

% Generates a list of possible pars.
% Maximim value added to the list is '9876' as that is the largest 4 digit value that
% does not have any repeating values.
findPossiblePars(9999, [9999]).
findPossiblePars(N, [N|T])
    :- N < 9876,
        N1 is N+1,
        findPossiblePars(N1, T).

% Generates a list of pars.
% Minimum value added to the list is '1234' as that is the smallest 4 digit value that
% does not have any repeating values.
pars( PARS )
    :- findPossiblePars(1234, Y),
        include(par, Y, PARS).

% Returns the first element of a list.
firstElement(X,[X|_]).

% Returns true if the two numbers are a PARTY.
party( A,B )
    :- par(A),
        par(B),
        atom_chars( A,A1 ),
        atom_chars( B,B1 ),
        append( A1,B1,AB ),
        unique(AB),
        X = ['1','2','3','4','5','6','7','8','9'],
        subtract(X, AB, R),
        firstElement(MissingItem, R),
        atom_number(MissingItem, MissingNumber),
        0 is A mod MissingNumber,
        0 is B mod MissingNumber.

party( [A,B] )
    :- par(A),
        par(B),
        atom_chars( A,A1 ),
        atom_chars( B,B1 ),
        append( A1,B1,AB ),
        unique(AB),
        X = ['1','2','3','4','5','6','7','8','9'],
        subtract(X, AB, R),
        firstElement(MissingItem, R),
        atom_number(MissingItem, MissingNumber),
        0 is A mod MissingNumber,
        0 is B mod MissingNumber.

findPossiblePartys(PARS, PossiblePartys)
    :- findall([X,Y], (member(X, PARS), member(Y, PARS)), PossiblePartys).

sort_partys([], []).
sort_partys([H|T], X)
    :- sort(H, Y),
        append(PARTYS, [Y], X),
        sort_partys(T, PARTYS).

partys( PARTYS )
    :- pars( PARS ),
        findPossiblePartys(PARS, PossiblePartys),
        include(party, PossiblePartys, PARTYS_UNSORTED),
        sort_partys(PARTYS_UNSORTED, PARTYS_SORTED),
        sort(PARTYS_SORTED, PARTYS).

main
    :- par( 7826 ),
        pars( PARS ), write( PARS ),
        party( 9632, 5418 ),
        partys( PARTYS ), write( PARTYS ).
