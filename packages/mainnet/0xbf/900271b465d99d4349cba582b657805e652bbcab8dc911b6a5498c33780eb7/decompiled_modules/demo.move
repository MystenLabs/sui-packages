module 0xbf900271b465d99d4349cba582b657805e652bbcab8dc911b6a5498c33780eb7::demo {
    struct BobHouse has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    public fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : BobHouse {
        BobHouse{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    public fun say_hi() : 0x1::string::String {
        0x1::string::utf8(b"hello world")
    }

    // decompiled from Move bytecode v6
}

