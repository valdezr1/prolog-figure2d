/*Facts*/
point2d(X, Y).
segment(point2d(X, Y), point2d(X, Y)).
segment(point2d(X, Y), M, L).
square(point2d(X1,Y1), L).
rectangle(point2d(X1, Y1), point2d(X2, Y2)).
circle(point2d(X, Y), R).

/*Vertical*/
vertical(segment(point2d(X, Y), point2d(X, Y2))).

/*Horizontal*/
horizontal(segment(point2d(X1, Y), point2d(X2, Y))).

/*Parallel*/
parallel(
  segment(point2d(X1,Y1), point2d(X2, Y2)),
  segment(point2d(X3,Y3), point2d(X4, Y4))
):- (Y1 - Y2)/(X1 - X2) =:= (Y3 - Y4)/(X3 - X4).

/*Perpendicular*/
perpendicular(
  segment(point2d(X1,Y1), point2d(X2, Y2)),
  segment(point2d(X3,Y3), point2d(X4, Y4))
):- ((Y1 - Y2)/(X1 - X2)) =:= (-1 / ((Y3 - Y4)/(X3 - X4))).

/*Segment Contained in Circle*/
contained(
  segment(point2d(X1,Y1), point2d(X2, Y2)),
  circle(point2d(X, Y), R)
):- (
      (R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))),
      (R > (sqrt(((X2 - X)**2) + ((Y2 - Y)**2))))
    ).

/*Square Contained in Circle*/
contained(
  square(point2d(X1,Y1), L),
  circle(point2d(X,Y), R)
):- (
      (R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))),
      (R > (sqrt((((X1 + L) - X)**2) + ((Y1 - Y)**2)))),
      (R > (sqrt(((X1 - X)**2) + (((Y1 - L) - Y)**2)))),
      (R > (sqrt((((X1 + L) - X)**2) + (((Y1 - L) - Y)**2))))
    ).

/*Rectangle contained in Circle*/
contained(
  rectangle(point2d(X1, Y1), point2d(X2, Y2)),
  circle(point2d(X,Y), R)
):- (
      (R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))),
      (R > (sqrt(((X2 - X)**2) + ((Y2 - Y)**2)))),
      (R > (sqrt(((X1 - X)**2) + ((Y2 - Y)**2)))),
      (R > (sqrt(((X2 - X)**2) + ((Y1 - Y)**2))))
    ).

/*Square intersects with Rectangle*/
intersects(
  square(point2d(X, Y), L),
  rectangle(point2d(X1, Y1), point2d(X2, Y2))
):- (
      (
        ((X1 >= X), (X1 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((Y2 > Y) ; (Y2 < Y - L)),
        ((X2 < X) ; (X2 > X + L))
      );
      (
        ((X1 >= X), (X1 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((Y1 > Y) ; (Y1 < Y - L)),
        ((X2 < X) ; (X2 > X + L))
      );
      (
        ((X2 >= X), (X2 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((Y2 > Y) ; (Y2 < Y - L)),
        ((X1 < X) ; (X1 > X + L))
      );
      (
        ((X2 >= X), (X2 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((X1 < X) ; (X1 > X + L)),
        ((Y1 > Y) ; (Y1 < Y - L))
      );
      (
        ((X1 >= X), (X1 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((X1 >= X), (X1 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((X2 < X) ; (X2 > X + L))
      );
      (
        ((X1 >= X), (X1 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((X2 >= X), (X2 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((Y2 > Y) ; (Y2 < Y - L))
      );
      (
        ((X2 >= X), (X2 =< X + L), (Y1 =< Y), (Y1 >= Y - L)),
        ((X2 >= X), (X2 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((X1 < X) ; (X1 > X + L))
      );
      (
        ((X1 >= X), (X1 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((X2 >= X), (X2 =< X + L), (Y2 =< Y), (Y2 >= Y - L)),
        ((Y1 > Y) ; (Y1 < Y - L))
      )
    ).

/*Square intersects Circle*/
intersects(
  square(point2d(X, Y), L),
  circle(point2d(X1, Y1), R)
):- (
      not(contained(square(point2d(X, Y), L), circle(point2d(X1, Y1), R))),
      (
        (R > (sqrt(((X - X1)**2) + ((Y - Y1)**2))));
        (R > (sqrt((((X + L) - X1)**2) + ((Y - Y1)**2))));
        (R > (sqrt(((X - X1)**2) + (((Y - L) - Y1)**2))));
        (R > (sqrt((((X + L) - X1)**2) + (((Y - L) - Y1)**2))))
      )
    ).

/*Segment intersects Circle*/
intersects(
  circle(point2d(X,Y), R),
  segment(point2d(X1, Y1), point2d(X2, Y2))
):- (
      (
        not((R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2))))),
        (R > (sqrt(((X2 - X)**2) + ((Y2 - Y)**2))))
      );
      (
        (R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))),
        not((R > (sqrt(((X2 - X)**2) + ((Y2 - Y)**2)))))
      );
      (
        (R > (sqrt(((((X1+X2)/2) - X)**2) + ((((Y1+Y2)/2) - Y)**2)))),
        not((R > (sqrt(((X2 - X)**2) + ((Y2 - Y)**2))))),
        not((R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))))
      )
    ).

/*Point on Segment*/
on(point2d(X, Y), segment(point2d(X1, Y1), point2d(X2, Y2))):-
(
    X =< X1, X >= X2, Y =< Y1, Y >= Y2,
    Y =:= (((Y2 - Y1) / (X2 - X1)) * X) + (-1 *((((Y2 -Y1)/(X2-X1))*X1) - Y1))
).

/*Point on Circle*/
on(point2d(X, Y), circle(point2d(X1, Y2), R)):-
(
  (R**2) =:= ((X - X1)**2) + ((Y - Y2)**2)
).

/*Point in Circle*/
in(point2d(X1, Y1), circle(point2d(X, Y), R)):-
(
  R > (sqrt(((X1 - X)**2) + ((Y1 - Y)**2)))
).

/*Objects*/
Seg1 := segment(point2d(5, 4), point2d(5,5)).
Seg2 := segment(point2d(4, 12), point2d(6, 10)).
Rect1 := rectangle(point2d(9, 16), point2d(16, 14)). %Upper Left and Lower Right Corners
Rect2 := rectangle(point2d(3, 6), point2d(10, 3)). %Upper Left and Lower Right Corners
Sq1 := square(point2d(3, 13), 4). %Upper Left corner and length of side
Sq2 := square(point2d(11, 6), 2). %Upper Left corner and length of side
Cir := circle(point2d(12, 4), 3). %Center, radius
pt1 := point2d(12, 2).
pt2 := point2d(4, 13).
pt3 := point2d(20, 1).
