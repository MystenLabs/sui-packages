module 0x2f3a6c11d5708f983690da6c2d57d7e13c9b02e13b807b145dafdc12c920a879::osail_30jul2026 {
    struct OSAIL_30JUL2026 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_30JUL2026, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_30JUL2026>(arg0, 6, b"oSAIL-30Jul2026", b"oSAIL-30Jul2026", b"Full Sail option token, expiration 30 Jul 2026 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_30JUL2026>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_30JUL2026>>(v1);
    }

    // decompiled from Move bytecode v7
}

