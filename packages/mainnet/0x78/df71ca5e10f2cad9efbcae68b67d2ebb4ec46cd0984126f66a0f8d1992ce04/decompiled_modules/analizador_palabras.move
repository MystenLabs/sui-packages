module 0x78df71ca5e10f2cad9efbcae68b67d2ebb4ec46cd0984126f66a0f8d1992ce04::analizador_palabras {
    struct Analizador has key {
        id: 0x2::object::UID,
        propietario: address,
        total_palabras: u64,
        total_caracteres: u64,
        total_oraciones: u64,
        palabra_mas_larga: u64,
        analisis_realizados: u64,
    }

    public fun analizar_texto(arg0: &mut Analizador, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        arg0.total_caracteres = arg0.total_caracteres + v0;
        arg0.analisis_realizados = arg0.analisis_realizados + 1;
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            if (*0x1::vector::borrow<u8>(&arg1, v2) == 32) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        arg0.total_palabras = arg0.total_palabras + v1 + 1;
    }

    public fun crear_analizador(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Analizador{
            id                  : 0x2::object::new(arg0),
            propietario         : 0x2::tx_context::sender(arg0),
            total_palabras      : 0,
            total_caracteres    : 0,
            total_oraciones     : 0,
            palabra_mas_larga   : 0,
            analisis_realizados : 0,
        };
        0x2::transfer::transfer<Analizador>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun obtener_estadisticas(arg0: &Analizador) : (u64, u64, u64) {
        (arg0.total_palabras, arg0.total_caracteres, arg0.total_oraciones)
    }

    public fun obtener_promedio_palabras(arg0: &Analizador) : u64 {
        if (arg0.total_oraciones == 0) {
            return 0
        };
        arg0.total_palabras / arg0.total_oraciones
    }

    public fun registrar_oraciones(arg0: &mut Analizador, arg1: u64) {
        arg0.total_oraciones = arg0.total_oraciones + arg1;
    }

    public fun registrar_palabra_larga(arg0: &mut Analizador, arg1: u64) {
        if (arg1 > arg0.palabra_mas_larga) {
            arg0.palabra_mas_larga = arg1;
        };
    }

    // decompiled from Move bytecode v6
}

