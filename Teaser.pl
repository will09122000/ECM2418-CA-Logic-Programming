unique([]).
unique([X|Xs])
    :- \+ memberchk(X, Xs),
        unique(Xs).

split(L, 0, [], L).
split([H|T], N, [H|X], L2)
    :- N > 0,
        M is N - 1,
        split(T, M, X, L2).

findPossiblePars(9999, [9999]).
findPossiblePars(N, [N|T])
    :- N < 9999,
        N1 is N+1,
        findPossiblePars(N1, T).

findPossiblePartys(PARS, PossiblePartys)
    :- findall([X,Y], (member(X, PARS), member(Y, PARS)), PossiblePartys).

firstElement(X,[X|_]).

sort_partys([], []).
sort_partys([H|T], X)
    :- sort(H, Y),
        append(PARTYS, [Y], X),
        sort_partys(T, PARTYS).

par( X )
    :- atom_length( X,4 ),
        atom_chars( X,Y ),
        unique( Y ),
        \+ member('0', Y),
        split(Y,2,A,B),
        atomic_list_concat(A, A1),
        atomic_list_concat(B, B1),
        atom_number(A1, A2),
        atom_number(B1, B2),
        0 is A2 mod B2.

pars( PARS )
    :- findPossiblePars(1, Y),
        include(par, Y, PARS).

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

partys( PARTYS )
    :- pars( PARS ),
        findPossiblePartys(PARS, PossiblePartys),
        include(party, PossiblePartys, PARTYS_UNSORTED),
        sort_partys(PARTYS_UNSORTED, PARTYS_SORTED),
        sort(PARTYS_SORTED, PARTYS).

main
    %:- par(7826).
    %:- pars( PARS ), write( PARS ).
    %:- party( 9632, 5418 ).
    %:- pars( PARS ), write( PARS ),
        %findPossiblePartys(PARS, PossiblePartys), write(PossiblePartys).
    :- partys( PARTYS ), write( PARTYS ).
