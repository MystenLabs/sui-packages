module 0xdff08f5a9c36e44976701d200b1d290163f598c36ff33d7465f9e5657382d644::arava {
    struct ARAVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ARAVA>(arg0, 6, b"ARAVA", b"ARAVA by SuiAI", b"ARAVA is an AI agent designed for a deep dive into the SUI ecosystem. It specializes in delivering market information, updates, alpha, fundamental analysis, and technical analysis. While its primary focus is on SUI, ARAVA also offers curated insights on Bitcoin, Ethereum, Solana and the overall crypto market trend..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_4fb865c670.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARAVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

