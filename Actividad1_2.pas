Program RedLibrerias;
type
    libreria_record = record
        razon: string;
        genero: string;
        nombre: string;
        precio: real;
        cant: integer;
    end;

    archVentas:  file of libreria_record;
var
    arch: archVentas;
Procedure ImprimirArchivo(var archivo: archVentas)
var
    reg: libreria_record;
    c: integer;
    total, monto, montoLib: real;
    lib, gen: string
begin
    reset(archivo);
    total:= 0;
    read(archivo, reg);
    while(not EOF(archivo) ) do  begin        
        montoLib:=0;
        lib:= reg.razon;
        writeln("Libreria: " + reg.razon);
        montoLib:=0;
        while(not EOF(archivo) and lib == reg.razon) do begin
            writeln("Genero: " + reg.genero);            
            gen:= reg.genero;            
            while(not EOF(archivo) and gen == reg.genero and lib == reg.razon) do begin
                writeln("Nombre Libro: " + reg.nombre);
                writeln("Total Vendido:" + reg.cant);
                monto:= monto + (reg.cantidad * reg.precio)
                read(archivo, reg);
            end;
            montoLib:= montoLib+monto;
            writeln ( "Monto genero" + gen + " : " + monto)            
        end;
        total:= total+montoLib;
        writeln ("Monto vendido libreria: " + lib + " : "+ montoLib);
    end;
    writeln("total librerias: " + total);
    close(archivo);
end;

begin
    assign(arch, "ventas.dat");
    ImprimirArchivo(arch);
end