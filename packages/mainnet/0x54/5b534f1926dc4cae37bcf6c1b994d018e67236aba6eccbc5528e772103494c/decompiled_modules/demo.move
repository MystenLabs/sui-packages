module 0x545b534f1926dc4cae37bcf6c1b994d018e67236aba6eccbc5528e772103494c::demo {
    struct BobHouse has store, key {
        id: 0x2::object::UID,
        value: 0x1::string::String,
    }

    public fun mint_bob(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : BobHouse {
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

