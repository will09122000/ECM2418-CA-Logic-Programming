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

isWord( X, Y )
    :- atom_length(X, XL),
        atom_length(Y, YL),
        writeln([XL, YL]).




findWord( X )
    :- forall( animal(Y), isWord(X, Y) ).
    
append3(X, Y, Z, Total) :-
    append(X, YZ, Total),
    append(Y, Z, YZ).



main :-
    MyAnimal = '452589',
    MyVegetable = '658785',
    MyMineral = '7378719',
    atom_chars(MyAnimal, MyAnimalList),
    atom_chars(MyVegetable, MyVegetableList),
    atom_chars(MyMineral, MyMineralList),
    append3(MyAnimalList, MyVegetableList, MyMineralList, T),
    sort(T, T1),
    writeln( T1 ),
    Word = [0,0,0,0,0,0,0,0,0].
    %:- animal( dingo ).
    %atom_chars( test, X ), write(X).