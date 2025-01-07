module 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun size() : u16 {
        5
    }

    // decompiled from Move bytecode v6
}

