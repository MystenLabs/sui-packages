module 0xd69312c650c8234ad483673a669bd1de95b5045f3e0924f7b3a2fb4964381593::nrai {
    struct NRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NRAI>(arg0, 6, b"NRAI", b"NeuroAI by SuiAI", b"NeuroAI is a cutting-edge cryptocurrency designed for AI-powered ecosystems. Leveraging blockchain technology, it enables seamless, secure, and decentralized transactions within artificial intelligence networks. Its core utilities include incentivizing data sharing, supporting AI model development, and fostering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AI_1_d032cedb9f_6796ffbee4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

