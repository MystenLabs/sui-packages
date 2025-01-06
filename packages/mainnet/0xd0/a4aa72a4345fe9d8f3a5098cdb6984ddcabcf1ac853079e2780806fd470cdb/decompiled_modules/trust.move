module 0xd0a4aa72a4345fe9d8f3a5098cdb6984ddcabcf1ac853079e2780806fd470cdb::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUST>(arg0, 6, b"TRUST", b"Trust The Process. by SuiAI", b"AGENT TRUST is designed to embody and promote the principles of growth, resilience, collaboration, and sustainability. This AI agent inspires personal and collective development while fostering a community of empowered individuals who value trust in the process of life and success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_05_at_8_12_57_PM_fa34ad0f81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

