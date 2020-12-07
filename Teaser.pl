% Checks that all 4 digits in the possible par are unique.
unique( [] ).
unique( [H|T] )
    :- \+ memberchk( H, T ),
        unique( T ).

% Split the par into 2 halves.
split( X, 0, [], X ).
split( [H|T], S, [H|T1], X1 ) 
    :- S > 0,
        S1 is S - 1,
        split( T, S1, T1, X1 ).

% Returns true if the number is a par.
par( X )
    :- atom_length( X, 4 ),
        atom_chars( X, Y ),
        unique( Y ),
        % Check that the possible par does not contain a '0'.
        \+ member('0', Y),
        % Check that the second two digits is a factor of the first 2 digits.
        split( Y, 2, A, B ),
        atomic_list_concat( A, A1 ),
        atomic_list_concat( B, B1 ),
        atom_number( A1, A2 ),
        atom_number( B1, B2 ),
        0 is A2 mod B2.

% Generates a list of possible pars.
% Maximim value added to the list is '9876' as that is the largest 4 digit value that
% does not have any repeating values.
findPossiblePars( 9876, [9876] ).
findPossiblePars( N, [N|T] )
    :- N < 9876,
        N1 is N + 1,
        findPossiblePars( N1, T ).

% Returns a list of all pars.
% Minimum value added to the list is '1234' as that is the smallest 4 digit value that
% does not have any repeating values.
pars( PARS )
    :- findPossiblePars( 1234, X ),
        include( par, X, PARS ).

% Returns the first element of a list.
firstElement( X, [X|_] ).

% Returns true if the two numbers are a PARTY.
party( A, B )
    :- par( A ),
        par( B ),
        atom_chars( A, A1 ),
        atom_chars( B, B1 ),
        append( A1, B1, AB ),
        unique( AB ),
        X = ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
        subtract( X, AB, R ),
        firstElement( MissingItem, R ),
        atom_number( MissingItem, MissingNumber ),
        0 is A mod MissingNumber,
        0 is B mod MissingNumber.

% Returns true if the two numbers in the list are a PARTY.
% I realise it is not ideal to repeat code like this but I could not figure out
% how to use the original party(A,B) in include() on line 95.
partyList( [A,B] )
    :- par( A ),
        par( B ),
        atom_chars( A, A1 ),
        atom_chars( B, B1 ),
        append( A1, B1, AB ),
        unique( AB ),
        X = ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
        subtract( X, AB, R ),
        firstElement( MissingItem, R ),
        atom_number( MissingItem, MissingNumber ),
        0 is A mod MissingNumber,
        0 is B mod MissingNumber.

% Generates a list of all possible party combinations.
findPossiblePartys( PARS, PossiblePartys )
    :- findall( [X,Y], ( member( X, PARS ), member( Y, PARS ) ), PossiblePartys ).

% Orders each pair so repeats can easily be indentified.
sort_partys( [], [] ).
sort_partys( [H|T], X )
    :- sort( H, Y ),
        append( PARTYS, [Y], X ),
        sort_partys( T, PARTYS ).

% Returns a list of all partys.
partys( PARTYS )
    :- pars( PARS ),
        findPossiblePartys( PARS, PossiblePartys ),
        include( partyList, PossiblePartys, PartysWithDuplicates ),
        sort_partys( PartysWithDuplicates, PartysWithDuplicatesSorted ),
        % Removes duplicates.
        list_to_set( PartysWithDuplicatesSorted, PARTYS ).

% Tested on https://swish.swi-prolog.org/
main
    % Question 2.1
    :- par( 7826 ).

    % Question 2.2
    %:- pars( PARS ), writeln( PARS ).

    % Question 2.3
    %:- party( 9632, 5418 ).

    % Question 2.4
    %:- partys( PARTYS ), write( PARTYS ).
