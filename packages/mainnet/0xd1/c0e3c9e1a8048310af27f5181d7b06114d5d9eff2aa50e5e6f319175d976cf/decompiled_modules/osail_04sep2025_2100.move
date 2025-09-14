module 0xd1c0e3c9e1a8048310af27f5181d7b06114d5d9eff2aa50e5e6f319175d976cf::osail_04sep2025_2100 {
    struct OSAIL_04SEP2025_2100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_04SEP2025_2100, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_04SEP2025_2100>(arg0, 6, b"oSAIL-04Sep2025-2100", b"oSAIL-04Sep2025-2100", b"Full Sail option token, expiration 04 Sep 2025 21:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_04SEP2025_2100>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_04SEP2025_2100>>(v1);
    }

    // decompiled from Move bytecode v6
}

