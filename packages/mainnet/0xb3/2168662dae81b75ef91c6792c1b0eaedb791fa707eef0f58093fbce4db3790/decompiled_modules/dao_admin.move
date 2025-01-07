module 0xb32168662dae81b75ef91c6792c1b0eaedb791fa707eef0f58093fbce4db3790::dao_admin {
    struct DaoAdmin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin<T0> {
        DaoAdmin<T0>{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

