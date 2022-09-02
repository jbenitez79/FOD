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

Program Farmacia
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
    archProd: file of producto;
    archDet: file of detalle;
    archText: file of text;
var
    fmae: archProd;
    fsuc: archDet;
Procedure ActualizarMaestro(var f_mae: archProd, var f_suc: archDet, var f_text: archText)
var    
    r_mae: producto;
    r_suc: detalle;
begin
   reset(f_mae);
   reset(f_suc);
   while not (EOF(f_suc)) do
        read(f_suc,r_suc)
        read(f_mae, r_mae)

        (*busco el registro a actualizar*)
        while(r_mae.codigo <> r_suc.codigo )do
            read(f_mae, r_mae)
        end

        (*actualizo el registro en maestro *)
        r_mae.stockDisp=r_mae.stockDisp - r_suc.cantV
        seek(f_mae, FilePos(f_mae)-1)
        write(f_mae, r_mae)

        (*si el stock disponible es menor que stockMin*)
        if(r_mae.stockDisp < r_mae.stockMin) then
            write (f_text, r_mae.codigo)
        end        
    end
    close(f_suc);
    close(f_mae);
end;

begin
    assign(fmae, "maestro");
    assign(ftext, "stockMinimo.txt");
    rewrite(ftext)

    assign(fsuc, "sucursal1");
    ActualizarMaestro(fmae, fsuc, ftext)

    assign(fsuc, "sucursal2");
    ActualizarMaestro(fmae, fsuc, ftext)

    assign(fsuc, "sucursal3");
    ActualizarMaestro(fmae, fsuc, ftext)

    assign(fsuc, "sucursal4");
    ActualizarMaestro(fmae, fsuc, ftext)
    
    close(ftext);
end;