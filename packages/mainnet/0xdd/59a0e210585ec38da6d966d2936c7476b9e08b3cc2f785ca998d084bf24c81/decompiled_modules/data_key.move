module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::data_key {
    struct DataKey has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DataKey {
        DataKey{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

