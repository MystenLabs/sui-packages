module 0x2cd31c4ed78396ce5060efa778ffe9b7ff9131774a7800b55cf0e165de4d6ecf::disfraces {
    struct Tienda_de_disfraces has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        disfraces: 0x2::vec_map::VecMap<u16, Disfraz>,
    }

    struct Disfraz has drop, store {
        modelo: 0x1::string::String,
        descripcion: 0x1::string::String,
        tallas: Talla,
        disponibilidad: bool,
        capital_producto: u64,
    }

    struct Talla has copy, drop, store {
        cantidad_chica: u64,
        precio_chica: u64,
        cantidad_mediana: u64,
        precio_mediana: u64,
        cantidad_grande: u64,
        precio_grande: u64,
    }

    public fun actualizar_cantidad(arg0: u16, arg1: u8, arg2: u64, arg3: &mut Tienda_de_disfraces) {
        assert!(0x2::vec_map::contains<u16, Disfraz>(&arg3.disfraces, &arg0), 13906834612430176259);
        let v0 = 0x2::vec_map::get_mut<u16, Disfraz>(&mut arg3.disfraces, &arg0);
        let v1 = v0.tallas;
        if (arg1 == 1) {
            v1.cantidad_chica = arg2;
        } else if (arg1 == 2) {
            v1.cantidad_mediana = arg2;
        } else if (arg1 == 3) {
            v1.cantidad_grande = arg2;
        };
        let v2 = calcular_capital(&v1);
        v0.tallas = v1;
        v0.capital_producto = v2;
        v0.disponibilidad = v2 > 0;
    }

    public fun actualizar_descripcion(arg0: u16, arg1: 0x1::string::String, arg2: &mut Tienda_de_disfraces) {
        assert!(0x2::vec_map::contains<u16, Disfraz>(&arg2.disfraces, &arg0), 13906834822883573763);
        0x2::vec_map::get_mut<u16, Disfraz>(&mut arg2.disfraces, &arg0).descripcion = arg1;
    }

    public fun actualizar_precio(arg0: u16, arg1: u8, arg2: u64, arg3: &mut Tienda_de_disfraces) {
        assert!(0x2::vec_map::contains<u16, Disfraz>(&arg3.disfraces, &arg0), 13906834724099325955);
        let v0 = 0x2::vec_map::get_mut<u16, Disfraz>(&mut arg3.disfraces, &arg0);
        let v1 = v0.tallas;
        if (arg1 == 1) {
            v1.precio_chica = arg2;
        } else if (arg1 == 2) {
            v1.precio_mediana = arg2;
        } else if (arg1 == 3) {
            v1.precio_grande = arg2;
        };
        v0.tallas = v1;
        v0.capital_producto = calcular_capital(&v1);
    }

    public fun agregar_disfraz(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u16, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut Tienda_de_disfraces) {
        assert!(!0x2::vec_map::contains<u16, Disfraz>(&arg9.disfraces, &arg2), 13906834419156516865);
        let v0 = Talla{
            cantidad_chica   : arg3,
            precio_chica     : arg4,
            cantidad_mediana : arg5,
            precio_mediana   : arg6,
            cantidad_grande  : arg7,
            precio_grande    : arg8,
        };
        let v1 = calcular_capital(&v0);
        let v2 = Disfraz{
            modelo           : arg0,
            descripcion      : arg1,
            tallas           : v0,
            disponibilidad   : v1 > 0,
            capital_producto : v1,
        };
        0x2::vec_map::insert<u16, Disfraz>(&mut arg9.disfraces, arg2, v2);
    }

    public fun calcular_capital(arg0: &Talla) : u64 {
        arg0.cantidad_chica * arg0.precio_chica + arg0.cantidad_mediana * arg0.precio_mediana + arg0.cantidad_grande * arg0.precio_grande
    }

    public fun crear_tienda(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda_de_disfraces{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            disfraces : 0x2::vec_map::empty<u16, Disfraz>(),
        };
        0x2::transfer::transfer<Tienda_de_disfraces>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_disfraz(arg0: u16, arg1: &mut Tienda_de_disfraces) {
        assert!(0x2::vec_map::contains<u16, Disfraz>(&arg1.disfraces, &arg0), 13906834565185536003);
        let (_, _) = 0x2::vec_map::remove<u16, Disfraz>(&mut arg1.disfraces, &arg0);
    }

    public fun eliminar_tienda(arg0: Tienda_de_disfraces) {
        let Tienda_de_disfraces {
            id        : v0,
            nombre    : _,
            disfraces : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

