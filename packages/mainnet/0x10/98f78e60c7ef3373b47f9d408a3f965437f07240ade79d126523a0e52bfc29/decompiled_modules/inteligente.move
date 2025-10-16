module 0x1098f78e60c7ef3373b47f9d408a3f965437f07240ade79d126523a0e52bfc29::inteligente {
    struct Vehiculo has copy, drop, store {
        placa: 0x1::string::String,
        modelo: 0x1::string::String,
    }

    struct Estacionamiento has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        espacios_totales: u16,
        espacios_ocupados: u16,
        vehiculos: vector<Vehiculo>,
    }

    public fun crear_estacionamiento(arg0: 0x1::string::String, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Estacionamiento{
            id                : 0x2::object::new(arg2),
            nombre            : arg0,
            espacios_totales  : arg1,
            espacios_ocupados : 0,
            vehiculos         : 0x1::vector::empty<Vehiculo>(),
        };
        0x2::transfer::transfer<Estacionamiento>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun espacios_disponibles(arg0: &Estacionamiento) : u16 {
        arg0.espacios_totales - arg0.espacios_ocupados
    }

    public fun listar_vehiculos(arg0: &Estacionamiento) : vector<0x1::string::String> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (v0 < 0x1::vector::length<Vehiculo>(&arg0.vehiculos)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::vector::borrow<Vehiculo>(&arg0.vehiculos, v0).placa);
            v0 = v0 + 1;
        };
        v1
    }

    public fun registrar_entrada(arg0: &mut Estacionamiento, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(arg0.espacios_ocupados < arg0.espacios_totales, 0);
        let v0 = Vehiculo{
            placa  : arg1,
            modelo : arg2,
        };
        0x1::vector::push_back<Vehiculo>(&mut arg0.vehiculos, v0);
        arg0.espacios_ocupados = arg0.espacios_ocupados + 1;
    }

    public fun registrar_salida(arg0: &mut Estacionamiento, arg1: 0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Vehiculo>(&arg0.vehiculos)) {
            if (0x1::vector::borrow<Vehiculo>(&arg0.vehiculos, v0).placa == arg1) {
                0x1::vector::swap_remove<Vehiculo>(&mut arg0.vehiculos, v0);
                arg0.espacios_ocupados = arg0.espacios_ocupados - 1;
                return
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

