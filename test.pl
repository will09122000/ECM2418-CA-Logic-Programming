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

tryCombination(X, Y, Z)
    :- Word = [0,0,0,0,0,0,0,0,0].

firstElement([X|_],X).

process(Position, ObjectLetter, WordList)
    :- nth0(Position, WordList, X),
        writeln(X).

do([],_,_).
do([H|T],[H1|T1], X)
    :- process(H,H1,X),
        do(T, T1, X).

spell(X, Y)
    :- atom_chars(X, Y).

main :-
    MyAnimal = [4,5,2,5,8,9],
    MyVegetable = [6,5,8,7,8,5],
    MyMineral = [7,3,7,8,7,1,9],
    findall( X, animal( X ), Animals ),
    findall( X, vegetable( X ), Vegetables ),
    findall( X, mineral( X ), Minerals ),
    removeImpossibleObjects(MyAnimal, Animals, Animals1),
    removeImpossibleObjects(MyVegetable, Vegetables, Vegetables1),
    removeImpossibleObjects(MyMineral, Minerals, Minerals1),
    Word = [0,0,0,0,0,0,0,0,0],
    firstElement(Animals1, PossibleAnimal),
    spell(PossibleAnimal, PossibleAnimal1),
    do(MyAnimal, PossibleAnimal1, Word).
    %:- animal( dingo ).
    %spell( PossibleAnimal, X ), write(X).