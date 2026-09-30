module 0x20daa86db5b6fcd3071a01eb6549ef3a6df37ef518c8e4b9bb61b61be6d929fd::cvid {
    struct CVID has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CVID>(arg0, 6, 0x1::string::utf8(b"CVID"), 0x1::string::utf8(b"Cat Videos First"), 0x1::string::utf8(b"Burning deadlines, purring timelines"), 0x1::string::utf8(b"https://popularsui.xyz/media/e33f05c9846adfd963b66607d667d73a74569e6c8ff602934e2c822312970142.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVID>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CVID>>(0x2::coin_registry::finalize<CVID>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

