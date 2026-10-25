module 0xba537244c2a24caf9128c2981dab2b68a087ea158af61973738b374a407cdcc8::mmmm {
    struct MMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MMMM>(arg0, 9, 0x1::string::utf8(b"MMMM"), 0x1::string::utf8(b"mkjkkjk"), 0x1::string::utf8(b"mkjkkjk (MMMM)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMMM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MMMM>>(0x2::coin_registry::finalize<MMMM>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

