module 0xa05ded4dfba436d2aece8863015ee2560810c44a81c6d6e55404fe934edb3c8f::genai {
    struct GENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENAI>(arg0, 6, b"GENAI", b"Genesis AI", b"Multi-AI Aggregation Engine. Smart Contract Generation (Sui, NFTs, DAOs). Intuitive No-Code Interface. Real-Time Code Optimization. Cross-Chain Compatibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738031247384.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

