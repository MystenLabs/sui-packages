module 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::collection {
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

