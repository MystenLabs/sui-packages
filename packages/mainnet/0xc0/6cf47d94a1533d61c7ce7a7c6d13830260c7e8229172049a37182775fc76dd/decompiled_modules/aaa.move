module 0xc06cf47d94a1533d61c7ce7a7c6d13830260c7e8229172049a37182775fc76dd::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"AAA by SuiAI", b"Get ready to level up with the agent made for gamers & game builders, powered by the SUIAI Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250116_000957_Chrome_09e196fdbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

