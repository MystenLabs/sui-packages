module 0x8b59ae1c959152ab1eb50f5e081ecd1794a7e6e9751f60e98599dd26229b20fd::CAPY_PAZA {
    struct CAPY_PAZA has drop {
        dummy_field: bool,
    }

    struct CAPY has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CAPY_PAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CAPY CAPY"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://asset.birds.dog/img/1/3.png"));
        let v4 = 0x2::package::claim<CAPY_PAZA>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CAPY>(&v4, v0, v2, arg1);
        0x2::display::update_version<CAPY>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CAPY>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CAPY{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<CAPY>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

