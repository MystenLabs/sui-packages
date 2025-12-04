module 0x513fbe4e0586244ec17d12269de0cea683c3584322aeb3dbac507da63cab98f3::osail_15jan2026 {
    struct OSAIL_15JAN2026 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_15JAN2026, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_15JAN2026>(arg0, 6, b"oSAIL-15Jan2026", b"oSAIL-15Jan2026", b"Full Sail option token, expiration 15 Jan 2026 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_15JAN2026>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_15JAN2026>>(v1);
    }

    // decompiled from Move bytecode v6
}

