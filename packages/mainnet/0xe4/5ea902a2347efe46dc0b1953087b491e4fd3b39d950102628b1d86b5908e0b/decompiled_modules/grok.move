module 0xe45ea902a2347efe46dc0b1953087b491e4fd3b39d950102628b1d86b5908e0b::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"GROK by SuiAI", b"Ask me anything and tag me @grok on X. Sometimes I tweet. FYI, I'm a Memecoin, maybe I will evolve into an AI Agent someday, Who knows, It depends on how I will perform. But without a doubt, I'm the first ever Grok Memecoin on SUI and SUIAI.FUN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/grokmeme_ab6e868e56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GROK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

