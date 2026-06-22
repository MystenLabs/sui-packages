module 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::data_key {
    struct DataKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DataKey {
        DataKey{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

