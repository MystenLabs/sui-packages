module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::world {
    struct GovernorCap has key {
        id: 0x2::object::UID,
        governor: address,
    }

    public fun id(arg0: &GovernorCap) : 0x2::object::ID {
        0x2::object::id<GovernorCap>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernorCap{
            id       : 0x2::object::new(arg0),
            governor : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<GovernorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

