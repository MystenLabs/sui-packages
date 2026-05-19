module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::data_key {
    struct DataKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DataKey {
        DataKey{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

