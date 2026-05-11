module 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::data_key {
    struct DataKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DataKey {
        DataKey{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

