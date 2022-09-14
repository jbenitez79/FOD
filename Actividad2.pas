(*
Se cuenta con un archivo de productos pertenecientes a una cadena de farmacias. De cada producto se
almacena: código del producto, nombre, stock disponible, stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 4 sucursales de la cadena. Se debe realizar el
procedimiento que recibe los 4 detalles y actualizar el stock del archivo maestro. La información que se recibe
en los detalles es: código de producto y cantidad vendida.
Además, se deberá informar en un archivo de texto el código de los productos que queden con stock
disponible por debajo del stock mínimo.

Nota: todos los archivos se encuentran ordenados por código de producto. En cada detalle puede venir 0, 1 o
más registros de un determinado producto.
*)

Program Farmacia;
const valorA:=9999;
type
    producto = record
        codigo: integer;
        nombre: string;
        stockDisp: integer;
        stockMin: integer;
        precio: real;
    end;
    detalle= record
        codigo: integer;
        cantV: integer;
    end;
    archMAE: file of producto;
    archDet: file of detalle;
    archText: file of text;

    listaArchDet: array [1..4] of archDet;
    listaMinDet: array [1..4] of detalle;

procedure Leer(var det:archDet; var regDet:detalle);
begin 
    if(not EoF(det))then
        read(det,regDet);
    else 
        regDet.codigo:=ValorA;
end;    
(*esto se debe reemplazar por un ArbolBinario o mejor por una MinHeap*)
procedure minimo(var det:listaArchDet; var listMin:listaMinDet;var min:detalle);
var
    posMin:integer;
Begin
    min:=listMin[1];
    posMin:=1
    for i:=2 to 4 do
    begin
    if(listMin[i].codigo < min.codigo)then
    begin
        min:=listMin[i];
        posMin:=i;        
    end;    
    Leer(det[posMin],listMin[posMin]);
end;

procedure Actualizar(var M:archMAE, var det:listaArchDet, var txt:archText );
var
listMin:listaMinDet; 
min:detalle; 
regM:producto;
begin
    for i:=1 to 4 do
        reset(det[i]);
        Leer(det[i],listMin[i]);
    end;
    reset(M);
    minimo(det,listMin,min);
    while(min.codigo <> ValorA)do
    begin
        while(min.codigo <> regM.codigo)do
        begin
            read(M,regM);
        end;
        while(regM.codigo = min.codigo) and (min.codigo <> ValorA)do
        begin
            regM.stockDisp:= regM.stockDisp + min.stockDisp;
            minimo(det,resto,min);
        end;
        seek(M,filepos(M)-1);
        write(M,regM);
        if regM.stockDisp <= regM.stockMin then
        begin
            write(txt, regM);
        end;
    end;
    close(M);
    for i:=1 to 4 do
        close(det[i]);
    end;
end;



var
    M:archMAE;
    det:listaArchDet;
    inf: archText
    i:integer;
    nombreDet:String;
begin
    for i:=1 to 4 do
    begin
        writeln('ESCRIBA UN NOMBRE PARA EL ARCHIVO: ');
        read(nombreDet);
        assign(det[i],nombreDet);
    end;
    assign(inf, "stockMin");
    rewrite(inf);
    Actualizar(M,det, inf);
    close(inf);
end.