module 0xcd04cc2c8d069f843b7210eb589f902a79afa7bd94295cbb43d03685c24f1ea4::osail_23oct2025 {
    struct OSAIL_23OCT2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_23OCT2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_23OCT2025>(arg0, 6, b"oSAIL-23Oct2025", b"oSAIL-23Oct2025", b"Full Sail option token, expiration 23 Oct 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_23OCT2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_23OCT2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

