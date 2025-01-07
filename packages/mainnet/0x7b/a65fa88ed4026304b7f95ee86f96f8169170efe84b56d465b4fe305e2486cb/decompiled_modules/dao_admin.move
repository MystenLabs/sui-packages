module 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::dao_admin {
    struct DaoAdmin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin<T0> {
        DaoAdmin<T0>{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

