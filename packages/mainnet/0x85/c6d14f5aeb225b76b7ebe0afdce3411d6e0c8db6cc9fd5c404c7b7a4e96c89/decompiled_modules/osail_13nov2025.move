module 0x85c6d14f5aeb225b76b7ebe0afdce3411d6e0c8db6cc9fd5c404c7b7a4e96c89::osail_13nov2025 {
    struct OSAIL_13NOV2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_13NOV2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_13NOV2025>(arg0, 6, b"oSAIL-13Nov2025", b"oSAIL-13Nov2025", b"Full Sail option token, expiration 13 Nov 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_13NOV2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_13NOV2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

