module 0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz {
    struct JacksonSharkzEgg has store, key {
        id: 0x2::object::UID,
    }

    struct OGJacksonSharkzEgg has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new_egg(arg0: &mut 0x2::tx_context::TxContext) : JacksonSharkzEgg {
        JacksonSharkzEgg{id: 0x2::object::new(arg0)}
    }

    public(friend) fun new_og_egg(arg0: &mut 0x2::tx_context::TxContext) : OGJacksonSharkzEgg {
        OGJacksonSharkzEgg{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

