module 0xba68b2b3329de5c59b993397e2fd8eae456a033fab3bde7d39ea73e99c9aa450::defiai {
    struct DEFIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEFIAI>(arg0, 6, b"DEFIAI", b"DeFi Analyzer by SuiAI", b"Agent DeFi is your all-in-one solution for mastering decentralized finance (DeFi) and yield farming. Powered by advanced AI, AI AGENT delivers real-time market analysis, personalized strategy recommendations, and comprehensive risk assessments to help you make smarter, data-driven decisions in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/61cf57e1_3f13_4738_b064_48cca5939a49_9a0e25f5d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEFIAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFIAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

