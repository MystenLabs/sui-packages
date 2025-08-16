module 0xd1c88495b68fda7f5a7e1bb2bf3cd15e3b342f09e0d899ffda650376817dbeaa::insignia_tesh {
    struct Insignia has store, key {
        id: 0x2::object::UID,
        curso: 0x1::string::String,
        descripcion: 0x1::string::String,
        emitida_por: address,
        fecha: u64,
    }

    public entry fun crear_insignia(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0, 100);
        let v1 = Insignia{
            id          : 0x2::object::new(arg5),
            curso       : 0x1::string::utf8(arg1),
            descripcion : 0x1::string::utf8(arg2),
            emitida_por : v0,
            fecha       : arg4,
        };
        0x2::transfer::public_transfer<Insignia>(v1, arg3);
    }

    public entry fun eliminar_insignia(arg0: Insignia, arg1: &mut 0x2::tx_context::TxContext) {
        let Insignia {
            id          : v0,
            curso       : _,
            descripcion : _,
            emitida_por : _,
            fecha       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun transferir_insignia(arg0: Insignia, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Insignia>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

