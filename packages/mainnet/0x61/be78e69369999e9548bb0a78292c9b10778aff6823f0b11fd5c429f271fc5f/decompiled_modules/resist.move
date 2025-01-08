module 0x61be78e69369999e9548bb0a78292c9b10778aff6823f0b11fd5c429f271fc5f::resist {
    struct RESIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RESIST>(arg0, 6, b"RESIST", b"RESIST by SuiAI", b"Resist the slave mind. Fuck the Liberals, restore masculinity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RESIST_f579d173c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RESIST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESIST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

