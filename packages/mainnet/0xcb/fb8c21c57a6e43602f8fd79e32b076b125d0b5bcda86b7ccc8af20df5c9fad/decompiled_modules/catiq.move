module 0xcbfb8c21c57a6e43602f8fd79e32b076b125d0b5bcda86b7ccc8af20df5c9fad::catiq {
    struct CATIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CATIQ>(arg0, 6, b"CATIQ", b"CAT Intelligence Quotient by SuiAI", b"CATIQ (CAT Intelligence Quotient)..Revolutionizing AI-Powered Crypto with Feline Finesse..CATIQ is an innovative cryptocurrency that combines artificial intelligence, blockchain technology, and a dash of feline intelligence...Inspired by the agility, adaptability, and curious nature of cats, CATIQ aims to:..1. Develop AI-driven trading bots for optimized investment strategies.2. Foster a community-driven ecosystem for AI-related research and development.3. Support the advancement of animal-friendly initiatives and charities..Join the CATIQ community to experience the future of AI-powered crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/CATIQ_bf0b1d89e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATIQ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIQ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

