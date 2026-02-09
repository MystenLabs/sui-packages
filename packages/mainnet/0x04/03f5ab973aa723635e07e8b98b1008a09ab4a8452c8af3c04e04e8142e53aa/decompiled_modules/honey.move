module 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HONEY>(arg0, 6, 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(x"546865206e617469766520746f6b656e206f6620486f6e6579506c61792e20506f776572732070726f6772616d6d61626c6520746f6b656e2065636f6e6f6d69637320e2809420747265617375726965732c206175746f6d61746564206275796261636b732c20766f6c756d652d626173656420726577617264732c20616e64206465666c6174696f6e6172792074617820726f7574696e67206163726f73732073656c662d65766f6c76696e672065636f6e6f6d696573206f6e205375692e"), 0x1::string::utf8(b"https://assets.honeyplay.fun/coins/honey.gif"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<HONEY>>(0x2::coin_registry::finalize<HONEY>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

