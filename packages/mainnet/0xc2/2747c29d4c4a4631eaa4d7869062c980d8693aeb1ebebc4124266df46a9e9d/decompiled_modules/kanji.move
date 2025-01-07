module 0xc22747c29d4c4a4631eaa4d7869062c980d8693aeb1ebebc4124266df46a9e9d::kanji {
    struct KANJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANJI>(arg0, 6, b"KANJI", b"KANJI SUI", b"The chipper little animal with a hat collection to rival a fashion icon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_67_65936f9460.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KANJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

