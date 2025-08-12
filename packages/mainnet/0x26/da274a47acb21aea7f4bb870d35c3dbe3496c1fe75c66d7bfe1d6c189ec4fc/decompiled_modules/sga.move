module 0x26da274a47acb21aea7f4bb870d35c3dbe3496c1fe75c66d7bfe1d6c189ec4fc::sga {
    struct SGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SGA>(arg0, 6, b"SGA", b"SUIGAMEAI", b"SUIGAME AI is a Squid Game-inspired AI agent built to guide users through the blockchain gaming world, focusing on the Sui ecosystem. It helps users make informed decisions in the evolving gaming environment by providing information about analysis of games on the market and potential risks. Decode the markets. Free minds. Be One.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Pqc54_A_Oc_400x400_b0872f620a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

