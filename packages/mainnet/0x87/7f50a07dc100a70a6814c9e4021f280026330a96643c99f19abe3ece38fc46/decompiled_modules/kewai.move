module 0x877f50a07dc100a70a6814c9e4021f280026330a96643c99f19abe3ece38fc46::kewai {
    struct KEWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KEWAI>(arg0, 6, b"KEWAI", b"KEWAI: Empowering the Future of AI-Driven Blockchain Solutions by SuiAI", b"KEWAI: Empowering the Future of AI-Driven Blockchain Solutions.$KEWAI is a revolutionary token that combines the power of Artificial Intelligence (AI) with the transparency and security of blockchain technology. Designed to build a smart and efficient digital ecosystem, $KEWAI is fully managed by advanced AI agents, enabling real-time, data-driven decision-making.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_17_152741_e457a2a4c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEWAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEWAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

