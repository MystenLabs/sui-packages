module 0x47e30db656b8ae4f2e2b4ee6b3911f62e939ebe5d4d9c27395c6a8d5d571ba26::eqwewq {
    struct EQWEWQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: EQWEWQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EQWEWQ>(arg0, 6, b"EQWEWQ", b"qweqwe by SuiAI", b"eqwew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_22_at_00_53_53_9a9a18c155.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EQWEWQ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EQWEWQ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

