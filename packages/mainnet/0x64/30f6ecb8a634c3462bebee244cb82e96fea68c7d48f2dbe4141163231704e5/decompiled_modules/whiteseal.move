module 0x6430f6ecb8a634c3462bebee244cb82e96fea68c7d48f2dbe4141163231704e5::whiteseal {
    struct WHITESEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITESEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITESEAL>(arg0, 6, b"WHITESEAL", b"white seal", b"Let the white seal save you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_02_07_53_0861baba62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITESEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITESEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

