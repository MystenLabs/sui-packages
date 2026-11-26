module 0x3ec7b7d3f6629aa80a4002b0a8cc3ccd0dccb15873148b95e303384e31228459::credit {
    struct CREDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREDIT, arg1: &mut 0x2::tx_context::TxContext) {
        0x3ec7b7d3f6629aa80a4002b0a8cc3ccd0dccb15873148b95e303384e31228459::tokens::create<CREDIT>(arg0, 0x1::string::utf8(b"AUC"), 0x1::string::utf8(b"ACT Universal Credits"), 0x1::string::utf8(b"Spend it in the ACT shop on Genesis items and future drops."), arg1);
    }

    // decompiled from Move bytecode v7
}

