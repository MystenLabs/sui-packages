module 0x829f5b585a3d0ef1540639f9e4ec745e4339e3b264c4b0f7c176b4d70fced4c3::collection {
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

