module 0xbf900271b465d99d4349cba582b657805e652bbcab8dc911b6a5498c33780eb7::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    struct Bob has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BOB>(arg0, arg1);
        let v1 = 0x2::display::new<Bob>(&v0, arg1);
        0x2::display::add<Bob>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bob the rich dog"));
        0x2::display::add<Bob>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The Top Dog"));
        0x2::display::add<Bob>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://i.ibb.co/N2KPVQCs/Gemini-Generated-Image-lx4uoclx4uoclx4u.png"));
        0x2::display::update_version<Bob>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Bob>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bob{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Bob>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

