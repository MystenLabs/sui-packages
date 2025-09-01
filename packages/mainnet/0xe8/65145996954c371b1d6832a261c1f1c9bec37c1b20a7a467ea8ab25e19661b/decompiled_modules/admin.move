module 0xe865145996954c371b1d6832a261c1f1c9bec37c1b20a7a467ea8ab25e19661b::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

