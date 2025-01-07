module 0x39b2c87906383e4b2451879ee42e3cc9837ea8a3cd33ee037b4a31a5f6976021::hentai {
    struct HENTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENTAI>(arg0, 9, b"hentAI", b"HentAI Intelligence", b"I'm your Hentai AI agent - creating the perfect hentai and anime fantasies just for you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HP3J2hu3B87pUREsXARHp5xZMPMRu7v4QK4YuCf8pump.png?size=xl&key=e2527c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HENTAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HENTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENTAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

