module 0x1877820b9bbb95e63e394ffdbef67f3fd53a2274a01057be404f2736a54164a::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPP>(arg0, 6, 0x1::string::utf8(b"PPP"), 0x1::string::utf8(b"Popular SUI"), 0x1::string::utf8(b"official coin launched by @popular_sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/66e0298994a7894ac28bab52ab140e1978fe826f7e33961ae1b715577a3b3fdc.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPP>>(0x2::coin_registry::finalize<PPP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

