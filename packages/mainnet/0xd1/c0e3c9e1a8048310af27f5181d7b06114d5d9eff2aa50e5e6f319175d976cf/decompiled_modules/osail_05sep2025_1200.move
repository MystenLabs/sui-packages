module 0xd1c0e3c9e1a8048310af27f5181d7b06114d5d9eff2aa50e5e6f319175d976cf::osail_05sep2025_1200 {
    struct OSAIL_05SEP2025_1200 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_05SEP2025_1200, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_05SEP2025_1200>(arg0, 6, b"oSAIL-05Sep2025-1200", b"oSAIL-05Sep2025-1200", b"Full Sail option token, expiration 05 Sep 2025 12:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_05SEP2025_1200>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_05SEP2025_1200>>(v1);
    }

    // decompiled from Move bytecode v6
}

