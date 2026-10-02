module 0xc608aea4db27ab5157a150b84f4332034ba0584b423e4906f54f70dc12aa4ae0::olson {
    struct OLSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<OLSON>(arg0, 6, 0x1::string::utf8(b"OLSON"), 0x1::string::utf8(x"4f4ce2809920534f4e"), 0x1::string::utf8(x"e2809c486f6c64206f6e2c206f6ce2809920736f6e2e205765e280997265206a7573742067657474696e6720737461727465642ee2809d"), 0x1::string::utf8(b"https://popularsui.xyz/media/ee11a68fd6c5213bbdef6ee0d61e00a11a2ea40b9555ea60bfe59010e99dae52.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLSON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<OLSON>>(0x2::coin_registry::finalize<OLSON>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

