module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pause_cap {
    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PauseCap {
        PauseCap{id: 0x2::object::new(arg0)}
    }

    public fun destroy(arg0: PauseCap) {
        let PauseCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun id(arg0: &PauseCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

