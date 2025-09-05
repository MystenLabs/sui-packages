module 0xe39ee7b26a7a33462874b798bb384ed5ce9f8fd77838619a30394836189964ca::consumo_gasolina {
    struct ConsumoGasolina has key {
        id: 0x2::object::UID,
        conductor: 0x1::string::String,
        vehiculo: 0x1::string::String,
        km_recorridos: u64,
        rendimiento_km_por_litro: u64,
        precio_por_litro: u64,
        litros_consumidos: u64,
        gasto_total: u64,
    }

    public entry fun actualizar_precio(arg0: &mut ConsumoGasolina, arg1: u64) {
        assert!(arg1 > 0, 3);
        arg0.precio_por_litro = arg1;
        arg0.gasto_total = arg0.litros_consumidos * arg1;
    }

    public fun comparar_gastos(arg0: &ConsumoGasolina, arg1: &ConsumoGasolina) : u64 {
        if (arg0.gasto_total > arg1.gasto_total) {
            arg0.gasto_total
        } else {
            arg1.gasto_total
        }
    }

    public entry fun duplicar_consumo(arg0: &ConsumoGasolina, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ConsumoGasolina{
            id                       : 0x2::object::new(arg1),
            conductor                : arg0.conductor,
            vehiculo                 : arg0.vehiculo,
            km_recorridos            : arg0.km_recorridos,
            rendimiento_km_por_litro : arg0.rendimiento_km_por_litro,
            precio_por_litro         : arg0.precio_por_litro,
            litros_consumidos        : arg0.litros_consumidos,
            gasto_total              : arg0.gasto_total,
        };
        0x2::transfer::transfer<ConsumoGasolina>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun es_economico(arg0: &ConsumoGasolina, arg1: u64) : bool {
        arg0.gasto_total < arg1
    }

    public fun generar_descripcion(arg0: &ConsumoGasolina) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"El conductor ");
        0x1::string::append(&mut v0, arg0.conductor);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"206d616e656ac3b320756e20"));
        0x1::string::append(&mut v0, arg0.vehiculo);
        0x1::string::append(&mut v0, 0x1::string::utf8(x"20706f72206d7563686f73206b696cc3b36d6574726f732e20476173746f20746f74616c3a20"));
        0x1::debug::print<u64>(&arg0.gasto_total);
        v0
    }

    public fun mostrar_consumo(arg0: &ConsumoGasolina) {
        let v0 = 0x1::string::utf8(b"Conductor: ");
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<0x1::string::String>(&arg0.conductor);
        let v1 = 0x1::string::utf8(x"566568c3ad63756c6f3a20");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<0x1::string::String>(&arg0.vehiculo);
        let v2 = 0x1::string::utf8(x"4b696cc3b36d6574726f73207265636f727269646f733a20");
        0x1::debug::print<0x1::string::String>(&v2);
        0x1::debug::print<u64>(&arg0.km_recorridos);
        let v3 = 0x1::string::utf8(b"Rendimiento (km/l): ");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<u64>(&arg0.rendimiento_km_por_litro);
        let v4 = 0x1::string::utf8(b"Precio por litro: ");
        0x1::debug::print<0x1::string::String>(&v4);
        0x1::debug::print<u64>(&arg0.precio_por_litro);
        let v5 = 0x1::string::utf8(b"Litros consumidos: ");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&arg0.litros_consumidos);
        let v6 = 0x1::string::utf8(b"Gasto total: ");
        0x1::debug::print<0x1::string::String>(&v6);
        0x1::debug::print<u64>(&arg0.gasto_total);
    }

    public entry fun registrar_consumo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg4 > 0, 2);
        let v0 = arg2 / arg3;
        let v1 = ConsumoGasolina{
            id                       : 0x2::object::new(arg5),
            conductor                : arg0,
            vehiculo                 : arg1,
            km_recorridos            : arg2,
            rendimiento_km_por_litro : arg3,
            precio_por_litro         : arg4,
            litros_consumidos        : v0,
            gasto_total              : v0 * arg4,
        };
        0x2::transfer::transfer<ConsumoGasolina>(v1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

