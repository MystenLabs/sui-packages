module 0x5f25494bdf8026d4a4ce6fd091c4f2d94511be2b33fd1844e5b5485dbb549e07::khaokheowzoo {
    struct KHAOKHEOWZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAOKHEOWZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAOKHEOWZOO>(arg0, 6, b"Khaokheowzoo", b"khaokheowzoo", b"khaokheowzoo: home of MooDeng, home of all animals meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZD_Fboxag_AAVM_Wk_fd58f25829.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAOKHEOWZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAOKHEOWZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

