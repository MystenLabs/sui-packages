module 0x51f08c10ed07416ef347d67a46e286b07f863f221fbb38e04200043d78adfe8e::collection {
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

