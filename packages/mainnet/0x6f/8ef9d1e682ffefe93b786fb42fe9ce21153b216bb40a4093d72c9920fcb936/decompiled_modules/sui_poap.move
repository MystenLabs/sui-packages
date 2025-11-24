module 0x6f8ef9d1e682ffefe93b786fb42fe9ce21153b216bb40a4093d72c9920fcb936::sui_poap {
    struct SUI_POAP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Poap has store, key {
        id: 0x2::object::UID,
        nombre_evento: 0x1::string::String,
        fecha: u64,
        ubicacion: 0x1::string::String,
        hash_imagen: 0x1::string::String,
        descripcion: 0x1::string::String,
    }

    fun init(arg0: SUI_POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUI_POAP>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{nombre_evento}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{descripcion}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ipfs.io/ipfs/{hash_imagen}"));
        let v5 = 0x2::display::new_with_fields<Poap>(&v0, v1, v3, arg1);
        0x2::display::update_version<Poap>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Poap>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_poap(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Poap{
            id            : 0x2::object::new(arg7),
            nombre_evento : arg1,
            fecha         : arg2,
            ubicacion     : arg3,
            hash_imagen   : arg4,
            descripcion   : arg5,
        };
        0x2::transfer::transfer<Poap>(v0, arg6);
    }

    // decompiled from Move bytecode v6
}

