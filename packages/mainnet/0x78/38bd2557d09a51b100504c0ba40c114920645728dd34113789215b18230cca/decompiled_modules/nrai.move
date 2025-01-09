module 0x7838bd2557d09a51b100504c0ba40c114920645728dd34113789215b18230cca::nrai {
    struct NRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NRAI>(arg0, 6, b"NRAI", b"NeuroAI by SuiAI", b"NeuroAI is a cutting-edge cryptocurrency designed for AI-powered ecosystems. Leveraging blockchain technology, it enables seamless, secure, and decentralized transactions within artificial intelligence networks. Its core utilities include incentivizing data sharing, supporting AI model development, and fostering collaboration across AI-driven platforms. NeuroAI represents the intersection of innovation and trust, empowering the next generation of AI applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AI_1_d032cedb9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

