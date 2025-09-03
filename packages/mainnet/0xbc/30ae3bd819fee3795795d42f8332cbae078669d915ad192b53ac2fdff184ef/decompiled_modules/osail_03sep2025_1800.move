module 0xbc30ae3bd819fee3795795d42f8332cbae078669d915ad192b53ac2fdff184ef::osail_03sep2025_1800 {
    struct OSAIL_03SEP2025_1800 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_03SEP2025_1800, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_03SEP2025_1800>(arg0, 6, b"oSAIL-03Sep2025-1800", b"oSAIL-03Sep2025-1800", b"Full Sail option token, expiration 03 Sep 2025 18:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_03SEP2025_1800>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_03SEP2025_1800>>(v1);
    }

    // decompiled from Move bytecode v6
}

