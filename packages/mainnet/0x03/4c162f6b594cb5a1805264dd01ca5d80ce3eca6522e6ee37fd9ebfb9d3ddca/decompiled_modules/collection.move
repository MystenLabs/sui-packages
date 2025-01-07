module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun size() : u16 {
        3333
    }

    // decompiled from Move bytecode v6
}

