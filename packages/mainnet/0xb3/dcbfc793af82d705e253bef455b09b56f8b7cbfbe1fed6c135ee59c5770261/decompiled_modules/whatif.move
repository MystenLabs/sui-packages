module 0xb3dcbfc793af82d705e253bef455b09b56f8b7cbfbe1fed6c135ee59c5770261::whatif {
    struct WHATIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHATIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WHATIF>(arg0, 6, b"WHATIF", b"WhatIf Token", b"It all starts with what if? What if... What if this, what if that... Join our community and find the answers to your questions! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/Ek4IMv.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHATIF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHATIF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

