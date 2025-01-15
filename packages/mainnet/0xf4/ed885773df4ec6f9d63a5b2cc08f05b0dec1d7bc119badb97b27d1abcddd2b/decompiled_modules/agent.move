module 0xf4ed885773df4ec6f9d63a5b2cc08f05b0dec1d7bc119badb97b27d1abcddd2b::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"MatrixOracle", b"Matrix Oracle is the first AI agent on SUI that crafts new narratives, driven by your engagement. It adapts and evolves in real time, offering a personalized, immersive storytelling experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004182_79ddd6314b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

