Program Municipios;
type
    municipio = record
        nombre: string;
        descripcion: string;
        cantHab: integer;
        extension: integer;
        añoFund: integer;
    end;
    archMun: file of municipio;

Procedure ExisteMunicipio(var f: archMun, nombre: string, var existe: boolean)
var
    reg: municipio;

begin
    existe= false;
    seek(f, 1)    
    while (not EOF(f) and not existe) do
        read(f,reg)
        if (reg.nombre = nombre and reg.cantHab > 0) then
            existe=true;
        end;
    end;    
end;

Procedure AltaMunicipio(var f: archMun)
var
    nuevo, aux: municipio;
    existe: boolean;
    p: integer;
begin
    IngresarMunicipio(nuevo); (*Lee por teclado los datos del nuevo mun*)
    ExisteMunicipio(f, nuevo.nombre, existe)
    if (existe) then writeln("ya existe el municipio");
    else
        seek(f, 0);
        read (f, aux)
        if (aux.cantHab = 0)then
            seek(f, FileSize(f));
            write(f, nuevo);
        else
            p:= aux.cantHab * (-1);
            seek(f, p);
            read(f, aux);
            seek(f, p);
            write(f,nuevo)
            seek(f, 0);
            write(f, aux);
        end;
    end;
end;

Procedure BajaMunicipio(var f:archMun);
var
    reg, cab: municipio;
    existe: boolean;
    p: integer;
    nombre: string;
begin
    seek(f, 0);
    read(f, cab);
    write("Ingrese nombre de municipio a borrar");
    read(nombre)
    ExisteMunicipio(f, nombre, existe)
    if (not existe) then writeln("Municipio no existente");
    else
        p:=FilePos(f)-1;
        seek(f, p);
        read(f, reg);
        
        reg.cantHab=cab.cantHab;
        cab.cantHab=p * (-1)

        seek(f,p);
        write(f, reg);
        seek(f,0);        
        write(f, cab)
    end;
end;

