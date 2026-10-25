module 0xeecec1f293cfd4882266193db325f517ec1af55d4d016a360c798e5559cc82f5::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HAHA>(arg0, 9, 0x1::string::utf8(b"HAHA"), 0x1::string::utf8(b"hitl"), 0x1::string::utf8(b"hitl (HAHA)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HAHA>>(0x2::coin_registry::finalize<HAHA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

