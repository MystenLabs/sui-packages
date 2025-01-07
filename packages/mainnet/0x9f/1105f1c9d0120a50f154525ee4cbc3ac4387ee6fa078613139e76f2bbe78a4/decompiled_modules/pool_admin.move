module 0x9f1105f1c9d0120a50f154525ee4cbc3ac4387ee6fa078613139e76f2bbe78a4::pool_admin {
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

