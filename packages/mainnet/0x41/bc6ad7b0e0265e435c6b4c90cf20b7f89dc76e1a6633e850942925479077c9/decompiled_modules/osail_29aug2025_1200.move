module 0x41bc6ad7b0e0265e435c6b4c90cf20b7f89dc76e1a6633e850942925479077c9::osail_29aug2025_1200 {
    struct OSAIL_29AUG2025_1200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_29AUG2025_1200, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_29AUG2025_1200>(arg0, 6, b"oSAIL-29Aug2025-1200", b"oSAIL-29Aug2025-1200", b"Full Sail option token, expiration 29 Aug 2025 12:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail14_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_29AUG2025_1200>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_29AUG2025_1200>>(v1);
    }

    // decompiled from Move bytecode v6
}

