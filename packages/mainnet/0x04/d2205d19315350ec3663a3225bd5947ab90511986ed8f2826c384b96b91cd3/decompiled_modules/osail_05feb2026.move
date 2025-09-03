module 0x4d2205d19315350ec3663a3225bd5947ab90511986ed8f2826c384b96b91cd3::osail_05feb2026 {
    struct OSAIL_05FEB2026 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_05FEB2026, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_05FEB2026>(arg0, 6, b"oSAIL-05Feb2026", b"oSAIL-05Feb2026", b"Full Sail option token, expiration 05 Feb 2026 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_05FEB2026>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_05FEB2026>>(v1);
    }

    // decompiled from Move bytecode v6
}

