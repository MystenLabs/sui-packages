module 0xbf900271b465d99d4349cba582b657805e652bbcab8dc911b6a5498c33780eb7::sarah {
    struct SARAH has drop {
        dummy_field: bool,
    }

    struct Sarah has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SARAH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SARAH>(arg0, arg1);
        let v1 = 0x2::display::new<Sarah>(&v0, arg1);
        0x2::display::add<Sarah>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sarah the fairy princess"));
        0x2::display::add<Sarah>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Sarah living in her palace"));
        0x2::display::add<Sarah>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://i.ibb.co/HLdRfdNx/Gemini-Generated-Image-hgr2izhgr2izhgr2.png"));
        0x2::display::update_version<Sarah>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Sarah>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Sarah{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Sarah>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

