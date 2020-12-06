% Animals
animal( aardvark ).
animal( antelope ).
animal( coyote ).
animal( dingo ).
animal( donkey ).
animal( elephant ).
animal( horse ).
animal( jaguar ).
animal( kangaroo ).

% Vegetables
vegetable( artichoke ).
vegetable( cabbage ).
vegetable( carrot ).
vegetable( celery ).
vegetable( leek ).
vegetable( lettuce ).
vegetable( marrow ).
vegetable( onion ).
vegetable( potato ).

% Minerals
mineral( anatase ).
mineral( basalt ).
mineral( cobolt ).
mineral( copper ).
mineral( galena ).
mineral( nickel ).
mineral( sodium ).
mineral( silver ).
mineral( zircon ).

% Spells out the word as a list of atoms.
spell( X, Y )
    :- atom_chars( X, Y ).

% Returns an Animal that is 6 letters long and has the same letter in
% the 2nd and 4th position of the word.
findAnimal( X, Animal )
    :- animal( X ),
        spell( X, [_, Y, _, Y, _, _] ),
        spell( X, Animal ).

% Returns a Vegetable that is 6 letters long and has the same letter in
% the 2nd and 5th position and the same letter in the 3rd and 6th
% position of the word
findVegetable( X, Vegetable )
    :- vegetable( X ),
        spell( X, [_, Y, Z, _, Z, Y] ),
        spell( X, Vegetable ).

% Returns a Mineral that is 7 letters long and has the same letter in
% the 1st, 3rd and 5th position of the word.
findMineral( X, Mineral )
    :- mineral( X ),
        spell( X, [Y, _, Y, _, Y, _, _] ),
        spell( X, Mineral ).

% Zips two lists to a list of lists.
% Used to assign each clue number to its corresponding letter.
zip( [X], [Y], [[X, Y]] ).
zip( [X|List1], [Y|List2], [[X,Y]|ListZipped] )
    :- zip( List1, List2, ListZipped ).

% Removes all integers from a list.
removeInts( [], [] ).
removeInts( [H|T], [H|T1] )
    :- \+ integer( H ),
        removeInts( T, T1 ).
removeInts( [_|T], T1 )
    :- removeInts( T, T1 ).

% Finds a solution to the niner.
main
    :- Clues = [4,5,2,5,8,9,6,5,8,7,8,5,7,3,7,8,7,1,9],
        % Finds the correct word for each category.
        findAnimal( _, Animal ),
        findVegetable( _, Vegetable ),
        findMineral( _, Mineral ),

        % Each word is joint together in a list to match the Clues list.
        append( Animal, PartialList, FullList ),
        append( Vegetable, Mineral, PartialList ),

        % Creates a list of lists.
        zip( FullList, Clues, X ),

        % Sorts the list of lists using the number and removes duplicates.
        sort( 2, @<, X, X1 ),

        % Converts the list of lists to one list.
        append( X1, X2 ),

        removeInts( X2, X3 ),
        atomic_list_concat( X3, Solution ),
        writeln( Solution ).
