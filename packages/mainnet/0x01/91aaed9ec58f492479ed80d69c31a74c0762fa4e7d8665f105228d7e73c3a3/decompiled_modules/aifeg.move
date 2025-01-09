module 0x191aaed9ec58f492479ed80d69c31a74c0762fa4e7d8665f105228d7e73c3a3::aifeg {
    struct AIFEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFEG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIFEG>(arg0, 6, b"AIFEG", b"AiFeg Agent by SuiAI", b"#AiFegAgent, Intelligence in action, shaping a decentralized, fast, and connected future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_88_583c8ea3a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIFEG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFEG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

