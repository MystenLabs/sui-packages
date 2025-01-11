module 0x63ebe74de6b79f9c470e6ff5faaba0bfab79fa59f1e2f0a4d6e314ebcfd882a4::aisu {
    struct AISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISU>(arg0, 6, b"AISU", b"AiSU  by SuiAI", b"AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aadd_a8ada4df63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

