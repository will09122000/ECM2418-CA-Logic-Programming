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

findAnimal(MyAnimal, MyAnimalList)
    :- animal(MyAnimal),
        spell(MyAnimal, [_,X,_,X,_,_]),
        spell(MyAnimal, MyAnimalList).

findVegetable(MyVegetable, MyVegetableList)
    :- vegetable(MyVegetable),
        spell(MyVegetable, [_,_,X,_,X,_]),
        spell(MyVegetable, MyVegetableList).

findMineral(MyMineral, MyMineralList)
    :- mineral(MyMineral),
        spell(MyMineral, [X,_,X,_,X,_,_]),
        spell(MyMineral, MyMineralList).

merge([X], [Y], [[X,Y]]).
merge([X|L1], [Y|L2], [[X,Y]|L3]):-merge(L1, L2, L3).

append3(Xs, Ys, Zs, XsYsZs) :-
   append(Xs, YsZs, XsYsZs),
   append(Ys, Zs, YsZs).


main
    :- MyAnimal = [4,5,2,5,8,9],
        MyVegetable = [6,5,8,7,8,5],
        MyMineral = [7,3,7,8,7,1,9],
        findAnimal(MyAnimal, MyAnimalList),
        writeln(MyAnimalList),
        findVegetable(MyVegetable, MyVegetableList),
        findMineral(MyMineral, MyMineralList),
        append3(MyAnimalList, MyVegetableList, MyMineralList, Test),
        append3(MyAnimal, MyVegetable, MyMineral, Clues),
        merge(Test, Clues, Test1),
        sort(2, @<, Test1, Test2),
        append(Test2, Test3),
        remove_integers(Test3, Test4),
        string_chars(Test4, Test5),
        writeln(Test5).
