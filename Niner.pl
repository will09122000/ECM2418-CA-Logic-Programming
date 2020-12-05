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

spell(X, Z)
    :- atom_chars(X, Z).

findAnimal(X, Animal)
    :- animal(X),
        spell(X, [_,Z,_,Z,_,_]),
        spell(X, Animal).

findVegetable(X, Vegetable)
    :- vegetable(X),
        spell(X, [_,_,Z,_,Z,_]),
        spell(X, Vegetable).

findMineral(X, Mineral)
    :- mineral(X),
        spell(X, [Z,_,Z,_,Z,_,_]),
        spell(X, Mineral).

merge([X], [Y], [[X,Y]]).
merge([X|L1], [Y|L2], [[X,Y]|L3])
    :- merge(L1, L2, L3).

append3(X, Y, Z, FullList)
    :- append(X, PartialList, FullList),
        append(Y, Z, PartialList).

remove_integers([],[]).
remove_integers([X|Xs],[X|Ys]) :-
        \+integer(X),!,
        remove_integers(Xs,Ys).
remove_integers([_|Xs],Ys) :-
        remove_integers(Xs,Ys).

main
    :- Clues = [4,5,2,5,8,9,6,5,8,7,8,5,7,3,7,8,7,1,9],
        findAnimal(_, Animal),
        findVegetable(_, Vegetable),
        findMineral(_, Mineral),
        append3(Animal, Vegetable, Mineral, X),
        merge(X, Clues, X1),
        sort(2, @<, X1, X2),
        append(X2, X3),
        remove_integers(X3, X4),
        atomic_list_concat(X4, X5),
        writeln(X5).
