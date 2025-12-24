module 0xfcfb51f097844df79eae3f919a4745b5727b2f5fa6d82f7718d897f9b4b97673::osail_16oct2025 {
    struct OSAIL_16OCT2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAIL_16OCT2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAIL_16OCT2025>(arg0, 6, b"oSAIL-16Oct2025", b"oSAIL-16Oct2025", b"Full Sail option token, expiration 16 Oct 2025 00:00:00 UTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://app.fullsail.finance/static_files/o_sail_coin.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAIL_16OCT2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSAIL_16OCT2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

