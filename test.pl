child(martha).
child(charlotte).
child(caroline).
child(laura).

descend(X,Y)
    :- child(X,Y).



main
    :- findall(X,descend(martha,X),Z),
        writeln(Z).