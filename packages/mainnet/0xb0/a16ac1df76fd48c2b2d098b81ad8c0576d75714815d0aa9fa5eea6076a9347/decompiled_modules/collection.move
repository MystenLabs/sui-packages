module 0xb0a16ac1df76fd48c2b2d098b81ad8c0576d75714815d0aa9fa5eea6076a9347::collection {
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

