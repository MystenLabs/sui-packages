module 0xe364a361406e7ab4ea4ec17cc4840b18737dd20bd7124a82130aa21422b8fc20::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 8, b"DOGE", b"Wrapped Coin for Doge", b"Sudo Wrapped Coin for Doge", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v0);
    }

    // decompiled from Move bytecode v6
}

