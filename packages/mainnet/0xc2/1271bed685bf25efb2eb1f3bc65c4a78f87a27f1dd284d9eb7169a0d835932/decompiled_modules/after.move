module 0xc21271bed685bf25efb2eb1f3bc65c4a78f87a27f1dd284d9eb7169a0d835932::after {
    struct AFTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AFTER>(arg0, 6, b"AFTER", b"After Token", b"$AFTER is the AI utility token from AfterShock Labs. It ships with a live community agent on day one and expands into a token-gated template marketplace (Notion + AI) where builders earn $AFTER for shipping real tools. Buy, hold, and use $AFTER to access the After Party, vote on marketplace listings, and power the AfterShock AI stack.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Jagged_Lightning_Bolt_Badge_Logo_removebg_preview_1_ee81050562.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFTER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

