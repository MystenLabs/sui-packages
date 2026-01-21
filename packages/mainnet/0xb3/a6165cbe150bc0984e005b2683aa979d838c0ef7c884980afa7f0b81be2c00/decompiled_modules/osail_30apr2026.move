module 0xb3a6165cbe150bc0984e005b2683aa979d838c0ef7c884980afa7f0b81be2c00::osail_30apr2026 {
    struct OSAIL_30APR2026 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_30APR2026, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_30APR2026>(arg0, 6, b"oSAIL-30Apr2026", b"oSAIL-30Apr2026", b"Full Sail option token, expiration 30 Apr 2026 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_30APR2026>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_30APR2026>>(v1);
    }

    // decompiled from Move bytecode v6
}

