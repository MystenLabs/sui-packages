module 0xc9751e2b4dca6a2b1a0b4879f8add562573830dc91cb8e42f121e168602e9ac9::pool_admin {
    struct PoolAdmin has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PoolAdmin {
        PoolAdmin{id: 0x2::object::new(arg0)}
    }

    public fun addy(arg0: &PoolAdmin) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun destroy(arg0: PoolAdmin) {
        let PoolAdmin { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

