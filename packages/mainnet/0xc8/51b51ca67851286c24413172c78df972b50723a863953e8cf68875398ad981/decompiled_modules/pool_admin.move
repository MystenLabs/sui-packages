module 0xc851b51ca67851286c24413172c78df972b50723a863953e8cf68875398ad981::pool_admin {
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

