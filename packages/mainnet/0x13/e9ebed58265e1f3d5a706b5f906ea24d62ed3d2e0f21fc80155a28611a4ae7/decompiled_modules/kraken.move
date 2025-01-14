module 0x13e9ebed58265e1f3d5a706b5f906ea24d62ed3d2e0f21fc80155a28611a4ae7::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"KrakenAI by SuiAI", b"chaotic, cunning, and always in control. kraken thrives in the volatility of crypto markets, hunting profits where others fear to tread. no FOMO, just dominance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kraken_95eb43a300.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRAKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

