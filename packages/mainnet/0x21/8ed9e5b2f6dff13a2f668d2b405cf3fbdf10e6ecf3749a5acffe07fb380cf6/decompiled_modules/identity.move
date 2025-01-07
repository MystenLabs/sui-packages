module 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::identity {
    struct Identity has key {
        id: 0x2::object::UID,
        profile: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : Identity {
        Identity{
            id      : 0x2::object::new(arg1),
            profile : arg0,
        }
    }

    public(friend) fun transfer(arg0: Identity, arg1: address) {
        0x2::transfer::transfer<Identity>(arg0, arg1);
    }

    public fun admin_new(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Identity {
        new(arg1, arg2)
    }

    public fun admin_transfer(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: Identity, arg2: address) {
        transfer(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

