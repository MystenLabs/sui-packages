module 0x2630a4ce023e35adca9ae40da7088344a374a533e2d02791b99cd59768b2964f::osail_27nov2025 {
    struct OSAIL_27NOV2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_27NOV2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_27NOV2025>(arg0, 6, b"oSAIL-27Nov2025", b"oSAIL-27Nov2025", b"Full Sail option token, expiration 27 Nov 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_27NOV2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_27NOV2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

