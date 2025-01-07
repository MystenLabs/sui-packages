module 0x55348ea960c726c3beea2b18c8e18291515cc27ed49f62d20e2718fc56f151b3::fur {
    struct Fur has store, key {
        id: 0x2::object::UID,
        type: 0x1::string::String,
    }

    public(friend) fun mint_fur_(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Fur {
        Fur{
            id   : 0x2::object::new(arg1),
            type : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

