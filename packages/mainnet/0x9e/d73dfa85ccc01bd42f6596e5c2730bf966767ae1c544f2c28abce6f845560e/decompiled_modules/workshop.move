module 0x9ed73dfa85ccc01bd42f6596e5c2730bf966767ae1c544f2c28abce6f845560e::workshop {
    struct Nexa has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        addy: address,
    }

    public fun create_nexa(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Nexa {
        Nexa{
            id   : 0x2::object::new(arg1),
            name : arg0,
            addy : 0x2::tx_context::sender(arg1),
        }
    }

    // decompiled from Move bytecode v6
}

