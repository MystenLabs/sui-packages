module 0xc76a2322f7c51ab3cb59288a4146741096fbd451e4f728d6ef841a1d904e072b::workshop {
    struct Workshop has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun create_workshop(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Workshop {
        Workshop{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

