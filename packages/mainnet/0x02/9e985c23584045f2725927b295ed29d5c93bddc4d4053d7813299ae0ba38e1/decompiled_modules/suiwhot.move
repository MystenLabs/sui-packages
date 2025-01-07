module 0x29e985c23584045f2725927b295ed29d5c93bddc4d4053d7813299ae0ba38e1::suiwhot {
    struct SUIWHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWHOT>(arg0, 6, b"SuiWhot", b"Suiwhot", b"SuiWhot is a fun and innovative token on the Sui blockchain, designed for fast-paced gaming and community engagement. Combining blockchain technology with playful utility, SuiWhot aims to bring excitement and rewards to the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d82071e9_589a_486e_ad69_28cf19098278_3bff8ba839.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

