module 0x7d8b582fa0c12a9921654c31341885f6dad35d6b37fc206b6591219ebb60e903::dao_admin {
    struct DaoAdmin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin<T0> {
        DaoAdmin<T0>{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

