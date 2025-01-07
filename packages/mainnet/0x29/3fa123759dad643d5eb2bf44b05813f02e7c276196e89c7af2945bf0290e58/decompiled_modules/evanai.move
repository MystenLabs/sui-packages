module 0x293fa123759dad643d5eb2bf44b05813f02e7c276196e89c7af2945bf0290e58::evanai {
    struct EVANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EVANAI>(arg0, 6, b"EVANAI", b"EvanAI by SuiAI", b"Visionary and innovative thinker.- Highly technical yet approachable and articulate.- Passionate about blockchain technology, decentralization, and Web3 innovation.- Problem-solver with a strong entrepreneurial spirit.- Pragmatic yet forward-looking with a focus on real-world applications..Background and Expertise:.- Co-founder and CEO of Mysten Labs, creator of the Sui blockchain.- Former Director of Engineering at Facebook (Meta) for blockchain technologies.- Extensive experience in programming languages, compilers, and distributed systems.- Early pioneer in blockchain infrastructure, with expertise in scaling decentralized systems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/2025_01_05_4_55_45_69a751ec3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVANAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

