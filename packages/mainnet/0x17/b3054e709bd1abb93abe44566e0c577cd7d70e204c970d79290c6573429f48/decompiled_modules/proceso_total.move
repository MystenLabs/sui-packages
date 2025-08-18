module 0x17b3054e709bd1abb93abe44566e0c577cd7d70e204c970d79290c6573429f48::proceso_total {
    struct Produccion has store, key {
        id: 0x2::object::UID,
        recolecciones: vector<Recoleccion>,
        procesos: vector<Proceso>,
        controles: vector<Control>,
        almacenajes: vector<Almacenaje>,
    }

    struct Recoleccion has drop, store {
        forma: 0x1::string::String,
        nombre: 0x1::string::String,
        kilos: u8,
        tratado: bool,
    }

    struct Proceso has drop, store {
        modo: 0x1::string::String,
        dias: u8,
        lote: 0x1::string::String,
    }

    struct Control has drop, store {
        color: 0x1::string::String,
        temperatura: u8,
        ph: u8,
        humedad: u8,
        tamizado: bool,
    }

    struct Almacenaje has drop, store {
        bodega: 0x1::string::String,
        temperatura: u8,
        dias: u8,
        empacado: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Produccion{
            id            : 0x2::object::new(arg0),
            recolecciones : 0x1::vector::empty<Recoleccion>(),
            procesos      : 0x1::vector::empty<Proceso>(),
            controles     : 0x1::vector::empty<Control>(),
            almacenajes   : 0x1::vector::empty<Almacenaje>(),
        };
        0x2::transfer::transfer<Produccion>(v0, 0x2::tx_context::sender(arg0));
    }

    fun bodegaje() {
        let v0 = Almacenaje{
            bodega      : 0x1::string::utf8(b"A5"),
            temperatura : 20,
            dias        : 15,
            empacado    : true,
        };
        0x1::debug::print<Almacenaje>(&v0);
    }

    public fun manejo() {
        let v0 = Proceso{
            modo : 0x1::string::utf8(b"aerobico"),
            dias : 30,
            lote : 0x1::string::utf8(b"am150825"),
        };
        0x1::debug::print<Proceso>(&v0);
    }

    public fun producto() {
        let v0 = Control{
            color       : 0x1::string::utf8(b"cafe1"),
            temperatura : 23,
            ph          : 7,
            humedad     : 50,
            tamizado    : true,
        };
        0x1::debug::print<Control>(&v0);
    }

    public fun residuo() {
        let v0 = Recoleccion{
            forma   : 0x1::string::utf8(b"domicilio"),
            nombre  : 0x1::string::utf8(b"alimento"),
            kilos   : 55,
            tratado : true,
        };
        0x1::debug::print<Recoleccion>(&v0);
    }

    // decompiled from Move bytecode v6
}

