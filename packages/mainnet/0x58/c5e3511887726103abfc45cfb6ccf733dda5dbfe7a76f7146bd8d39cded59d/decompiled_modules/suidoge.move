module 0x58c5e3511887726103abfc45cfb6ccf733dda5dbfe7a76f7146bd8d39cded59d::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 9, b"SDOGE", b"SuiDoge", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOGE>(&mut v2, 10000000000000000000, @0x2ef3f48323eb1e5f89c5ca777deeaeba556c0d752dfc5f6f4161cf799ff2ed6f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

