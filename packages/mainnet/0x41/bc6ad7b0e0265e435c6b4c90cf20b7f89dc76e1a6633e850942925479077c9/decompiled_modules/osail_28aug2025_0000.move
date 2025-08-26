module 0x41bc6ad7b0e0265e435c6b4c90cf20b7f89dc76e1a6633e850942925479077c9::osail_28aug2025_0000 {
    struct OSAIL_28AUG2025_0000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_28AUG2025_0000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_28AUG2025_0000>(arg0, 6, b"oSAIL-28Aug2025-0000", b"oSAIL-28Aug2025-0000", b"Full Sail option token, expiration 28 Aug 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail8_test_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_28AUG2025_0000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_28AUG2025_0000>>(v1);
    }

    // decompiled from Move bytecode v6
}

