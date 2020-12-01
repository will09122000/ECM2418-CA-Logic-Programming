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

isEqualLength( X, Y )
    :- atom_length(X, XLen),
        atom_length(Y, YLen),
        XLen is YLen.

removeImpossibleObjects(A, X, Y)
    :- include(isEqualLength(A), X, Y).

firstElement(X,[X|_]).

tryCombination(X, Y, Z)
    :- Word = [0,0,0,0,0,0,0,0,0].


main :-
    MyAnimal = '452589',
    MyVegetable = '658785',
    MyMineral = '7378719',
    findall( X, animal( X ), Animals ),
    findall( X, vegetable( X ), Vegetables ),
    findall( X, mineral( X ), Minerals ),
    removeImpossibleObjects(MyAnimal, Animals, Animals1),
    removeImpossibleObjects(MyVegetable, Vegetables, Vegetables1),
    removeImpossibleObjects(MyMineral, Minerals, Minerals1),
    writeln(Animals1),
    writeln(Vegetables1),
    writeln(Minerals1),
    Word = [0,0,0,0,0,0,0,0,0],
    firstElement(F1, Animals1),
    firstElement(F2, Animals1),
    firstElement(F3, Animals1),

    writeln(F1).
    %:- animal( dingo ).
    %atom_chars( test, X ), write(X).