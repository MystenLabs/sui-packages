module 0x9d1be1fac3ebfa4c9414ef077a18fce502b6958db53519e980377d383b8b77c3::game {
    struct Juego has key {
        id: 0x2::object::UID,
        numero_secreto: u64,
        intentos: u64,
        activo: bool,
    }

    public entry fun crear_juego(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Juego{
            id             : 0x2::object::new(arg1),
            numero_secreto : 0x2::clock::timestamp_ms(arg0) % 20 + 1,
            intentos       : 0,
            activo         : true,
        };
        0x2::transfer::transfer<Juego>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun esta_activo(arg0: &Juego) : bool {
        arg0.activo
    }

    public entry fun intentar(arg0: &mut Juego, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.intentos = arg0.intentos + 1;
        if (arg1 == arg0.numero_secreto) {
            let v0 = 0x1::string::utf8(x"f09fa5b320c2a146656c69636964616465732c206c65206174696e617374652120f09f8e89");
            0x1::debug::print<0x1::string::String>(&v0);
            arg0.activo = false;
        } else if (arg1 < arg0.numero_secreto) {
            let v1 = 0x1::string::utf8(x"457320756e206ec3ba6d65726f206dc3a17320616c746f20e2ac86efb88f");
            0x1::debug::print<0x1::string::String>(&v1);
        } else {
            let v2 = 0x1::string::utf8(x"457320756e206ec3ba6d65726f206dc3a1732062616a6f20e2ac87efb88f");
            0x1::debug::print<0x1::string::String>(&v2);
        };
    }

    public entry fun reiniciar(arg0: &mut Juego, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.numero_secreto = 0x2::clock::timestamp_ms(arg1) % 20 + 1;
        arg0.intentos = 0;
        arg0.activo = true;
        let v0 = 0x1::string::utf8(x"4a7565676f207265696e69636961646f20f09f9484");
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun ver_intentos(arg0: &Juego) : u64 {
        arg0.intentos
    }

    // decompiled from Move bytecode v6
}

