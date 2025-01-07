module 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::dao_admin {
    struct DaoAdmin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin<T0> {
        DaoAdmin<T0>{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

