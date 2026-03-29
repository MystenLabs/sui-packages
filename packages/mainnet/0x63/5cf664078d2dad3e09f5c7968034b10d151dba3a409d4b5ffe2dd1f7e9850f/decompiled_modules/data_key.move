module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::data_key {
    struct DataKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DataKey {
        DataKey{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

