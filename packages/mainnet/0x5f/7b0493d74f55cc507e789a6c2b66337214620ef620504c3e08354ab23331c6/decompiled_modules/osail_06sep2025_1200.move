module 0x5f7b0493d74f55cc507e789a6c2b66337214620ef620504c3e08354ab23331c6::osail_06sep2025_1200 {
    struct OSAIL_06SEP2025_1200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_06SEP2025_1200, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_06SEP2025_1200>(arg0, 6, b"oSAIL-06Sep2025-1200", b"oSAIL-06Sep2025-1200", b"Full Sail option token, expiration 06 Sep 2025 12:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_06SEP2025_1200>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_06SEP2025_1200>>(v1);
    }

    // decompiled from Move bytecode v6
}

