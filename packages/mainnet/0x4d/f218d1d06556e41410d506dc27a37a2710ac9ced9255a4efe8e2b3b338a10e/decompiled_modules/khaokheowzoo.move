module 0x4df218d1d06556e41410d506dc27a37a2710ac9ced9255a4efe8e2b3b338a10e::khaokheowzoo {
    struct KHAOKHEOWZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAOKHEOWZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAOKHEOWZOO>(arg0, 6, b"Khaokheowzoo", b"khaokheowzoo", b"khaokheowzoo: home of MooDeng, home of all animals meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZD_Fboxag_AAVM_Wk_20d404bc50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAOKHEOWZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAOKHEOWZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

