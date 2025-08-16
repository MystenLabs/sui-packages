module 0xaff06a94f0e5ceab27e6a6b35f3e032cf68f5a252177b98b39660622523f2e68::registro_vecinos {
    struct DatosPersonales has drop, store {
        nombre: 0x1::string::String,
        edad: u8,
    }

    struct Direccion has drop, store {
        calle: 0x1::string::String,
        numero: u64,
        ciudad: 0x1::string::String,
    }

    struct Contacto has drop, store {
        telefono: 0x1::string::String,
        email: 0x1::string::String,
    }

    struct Vecino has drop, store {
        datos: DatosPersonales,
        direccion: Direccion,
        contacto: Contacto,
    }

    struct RegistroVecinos has store, key {
        id: 0x2::object::UID,
        vecinos: vector<Vecino>,
    }

    public fun actualizar_nombre(arg0: &mut RegistroVecinos, arg1: u64, arg2: 0x1::string::String) {
        0x1::vector::borrow_mut<Vecino>(&mut arg0.vecinos, arg1).datos.nombre = arg2;
    }

    public fun agregar_vecino(arg0: &mut RegistroVecinos, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        assert!(arg2 > 0, 1);
        assert!(verificar_email(&arg7), 2);
        let v0 = DatosPersonales{
            nombre : arg1,
            edad   : arg2,
        };
        let v1 = Direccion{
            calle  : arg3,
            numero : arg4,
            ciudad : arg5,
        };
        let v2 = Contacto{
            telefono : arg6,
            email    : arg7,
        };
        let v3 = Vecino{
            datos     : v0,
            direccion : v1,
            contacto  : v2,
        };
        0x1::vector::push_back<Vecino>(&mut arg0.vecinos, v3);
    }

    public fun buscar_vecino_por_email(arg0: &RegistroVecinos, arg1: 0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Vecino>(&arg0.vecinos)) {
            if (0x1::vector::borrow<Vecino>(&arg0.vecinos, v0).contacto.email == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun cantidad_vecinos(arg0: &RegistroVecinos) : u64 {
        0x1::vector::length<Vecino>(&arg0.vecinos)
    }

    public fun crear_registro(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistroVecinos{
            id      : 0x2::object::new(arg0),
            vecinos : 0x1::vector::empty<Vecino>(),
        };
        0x2::transfer::transfer<RegistroVecinos>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_vecino(arg0: &mut RegistroVecinos, arg1: u64) {
        0x1::vector::remove<Vecino>(&mut arg0.vecinos, arg1);
    }

    fun verificar_email(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            if (*0x1::vector::borrow<u8>(v0, v1) == 64) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

