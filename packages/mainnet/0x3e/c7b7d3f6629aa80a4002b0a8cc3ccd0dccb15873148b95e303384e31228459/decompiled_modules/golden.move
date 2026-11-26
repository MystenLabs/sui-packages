module 0x3ec7b7d3f6629aa80a4002b0a8cc3ccd0dccb15873148b95e303384e31228459::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ec7b7d3f6629aa80a4002b0a8cc3ccd0dccb15873148b95e303384e31228459::tokens::create<GOLDEN>(arg0, 0x1::string::utf8(b"ACTG"), 0x1::string::utf8(b"ACT Golden Token"), 0x1::string::utf8(b"Redeems the Golden Set in the ACT shop."), arg1);
    }

    // decompiled from Move bytecode v7
}

