module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        AdminCap<T0>{id: 0x2::object::new(arg0)}
    }

    public fun destroy<T0>(arg0: AdminCap<T0>) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

